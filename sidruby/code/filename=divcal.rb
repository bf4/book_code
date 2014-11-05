#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'div'
require 'div/login'
require 'singleton'
require 'date'
require 'nkf'
require 'fake_login'

module DivCal
  $login_db = FakeLogin.new('fake_login.dat')
  class Login < Div::Login
    def get_user(user, phrase)
      $login_db.get_user(user, phrase)
    end
  end

  # DivCalの扱う予定を管理するクラス群。アプリケーションの本質部分である。
  class Event
    def initialize(text=nil, estimate=nil, actual=nil)
      @text = text
      @estimate = estimate
      @actual = actual
    end
    attr_accessor :text, :estimate, :actual

    def update(hash)
      @text = hash[:text] if hash.include?(:text)
      @estimate = hash[:estimate] if hash.include?(:estimate)
      @actual = hash[:actual] if hash.include?(:actual)
    end

    def ==(other)
      return false unless self.class == other.class
      @text == other.text && @actual == other.actual && 
      @estimate == other.estimate
    end
  end

  class EventTable
    def initialize
      @event = {}
    end
    attr_reader :event

    def store(date, event)
      @event[date.to_s] = event
    end

    def delete(date)
      @event.delete(date.to_s)
    end

    def fetch(date)
      @event[date.to_s]
    end

    def query_month(year, month)
      head = Date.new(year, month)
      tail = (head >> 1) - 1
      ary = []
      query(head, tail) do |date, event|
        ary.push([date, event])
      end
      ary
    end

    def query(head, tail)
      head.step(tail, 1) do |date|
        yield(date, fetch(date))
      end
    end

    def save(fname)
      tmp_fname = fname + '.tmp'
      File.open(tmp_fname, 'w') do |fp|
        fp.write(Marshal.dump(@event))
      end
      File.rename(tmp_fname, fname)
    rescue
    end

    def load(fname)
      File.open(fname) do |fp|
        @event = Marshal.load(fp.read)
      end
    rescue
    end
  end

  class EventDB
    include Singleton

    def initialize
      @table = {}
    end

    def [](name)
      @table[name] ||= load(name)
    end

    def filename(str)
      s = str.gsub(/([^a-zA-Z0-9_-])/n){ sprintf("%%%02X", $1.unpack("C")[0]) }
      s + '.dat'
    end

    def save(name)
      @table[name].save(filename(name))
    end

    def load(name)
      @table[name] = EventTable.new
      @table[name].load(filename(name))
      @table[name]
    end
  end

  # DivCalのデータベースEventDBのフロントエンド 
  class Front
    include MonitorMixin

    def initialize
      super
      @db = EventDB.instance
    end

    def query_month(name, year, month)
      synchronize do
        table = @db[name]
        table.query_month(year, month).collect do |event|
          event
        end
      end
    end

    def fetch(name, date)
      synchronize do
        table = @db[name]
        table.fetch(date)
      end
    end

    def delete(name, date)
      synchronize do
        table = @db[name]
        table.delete(date)
        @db.save(name)
      end
    end

    def update(name, date, hash)
      synchronize do
        event = fetch(name, date)
        event = entry(name, date) unless event
        event.update(hash)
        @db.save(name)
      end
    end

    private
    def entry(name, date)
      synchronize do
        table = @db[name]
        event = Event.new(date)
        table.store(date, event)
        event
      end
    end
  end

  # DivCalのUI（Divを用いたWeb UI）の作成
  class DivCalSession < Div::TofuSession
    def initialize(bartender, hint=nil)
      super(bartender, hint)
      @login = Login.new
      @base = BaseDiv.new(self)
    end
    attr_reader :login

    def hint
      if @login.login? && !@login.guest?
        @login.user
      else
        super
      end
    end

    def do_GET(context)
      update_div(context)
      context.res_header('content-type', 'text/html; charset=euc-jp')
      context.res_body(@base.to_html(context))
    end

    def kconv(str)
      NKF.nkf('-e', str.to_s)
    end
  end

  class LoginDiv < Div::LoginDiv
    set_erb('login.erb')
  end

  class BaseDiv < Div::Div
    set_erb('base.erb')

    def initialize(session)
      super(session)
      @cal = DivCalDiv.new(session)
      @login = LoginDiv.new(session, session.login, session.hint)
    end
  end

  class DivCalDiv < Div::Div
    set_erb('divcal.erb')

    class BGAttr
      def initialize(colors = ["#eeeeee", "#ffffff"])
        @colors = colors
        @cur = -1
      end

      def succ
        @cur = (@cur+1) % @colors.size
      end

      def to_s
        succ
        %Q+bgcolor="#{@colors[@cur]}"+
      end
    end

    def initialize(session)
      super(session)
      @cal = Front.new
      @div_seq = self.object_id.to_i
      @curr = Date.today
    end

    def query
      @cal.query_month(user, @curr.year, @curr.month)
    end

    def each
      empty_event = Event.new
      query.each do |date, event|
        yield(date, event || empty_event)
      end
    end

    def user
      return nil unless @session.login.login?
      @session.login.user
    end

    def to_args(param)
      date ,= param['date']
      text ,= param['text']
      estimate ,= param['estimate']
      actual ,= param['actual']
      args = {}

      args[:date] = Date.parse(date.to_s) rescue nil
      args[:text] = @session.kconv(text) if text
      if estimate.to_s.size > 0
        args[:estimate] = estimate.to_f rescue nil 
      end
      if actual.to_s.size > 0
        args[:actual] = actual.to_f rescue nil if actual
      end

      args
    end

    def do_delete(context, param)
      args = to_args(param)
      @cal.delete(user, args[:date])
    rescue
    end

    def do_update(context, param)
      args = to_args(param)
      @cal.update(user, @curr, args)
    rescue
    end

    def do_detail(context, param)
      args = to_args(param)
      @curr = args[:date] if args[:date]
    end
  end
end

if __FILE__ == $0
  tofu = Tofu::Bartender.new(DivCal::DivCalSession)
  DRb.start_service('druby://localhost:12345', tofu)
  DRb.thread.join
end
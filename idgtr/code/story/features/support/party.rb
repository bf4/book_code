#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'rubygems'
require 'selenium'
require 'time'
class Party
  def initialize(browser)
    @browser = browser
    @browser.open '/parties/new'
  end
  def self.def_setting(setting, type = :read_write)
    if type == :readable || type == :read_write
      define_method(setting) do
        @browser.get_text("id=party_#{setting}")
      end
      define_method("has_#{setting}?") do
        send(setting) rescue nil
      end
    end
    if type == :writable || type == :read_write
      define_method("#{setting}=") do |value|
        @browser.type "id=party_#{setting}", value
      end
    end
  end
  def_setting :name
  def_setting :description
  def_setting :location
  def_setting :link, :readable
  def_setting :notice, :readable
  def_setting :recipients, :writable
end


class Party
  def begins_at=(time); set_time(:begin, time) end
  def ends_at=  (time); set_time(:end, time) end
  def set_time(event, time)
    ['%Y', '%B', '%d', '%H', '%M'].each_with_index do |part, index|
      element = "id=party_#{event}s_at_#{index + 1}i"
      value = time.strftime part
      @browser.select element, value
    end
  end
end


class Party
  def begins_at; get_times.first end
  def ends_at;   get_times.last  end
  def get_times
    begins_on = @browser.get_text 'party_begins_on'
    begins_at = @browser.get_text 'party_begins_at'
    ends_at   = @browser.get_text 'party_ends_at'

    begins = Time.parse(begins_on + ' ' + begins_at)
    ends = Time.parse(begins_on + ' ' + ends_at)
    ends += 86400 if ends < begins

    [begins, ends]
  end

  def has_times?
    get_times rescue nil
  end
end


class Party
  def save_and_view
    @browser.click 'name=commit'
    @browser.wait_for_page_to_load 5000
    @saved = true
  end
end


class Party
  def rsvp(name, attending)
    @browser.type 'guest_name', name
    @browser.click 'guest_attending' unless attending
    @browser.click 'rsvp'
    @browser.wait_for_page_to_load 5000
  end
end


class Party
  RsvpItem = '//ul[@id="guests"]/li'
  
  def responses(want_attending)
    num_guests = @browser.get_xpath_count(RsvpItem).to_i
    return [] unless num_guests >= 1
    all = (1..num_guests).map do |i|
      name = @browser.get_text \
        "#{RsvpItem}[#{i}]/span[@class='rsvp_name']"
      rsvp = @browser.get_text \
        "#{RsvpItem}[#{i}]/span[@class='rsvp_attending']"
      [name, rsvp]
    end

    matching = all.select do |name, rsvp|
      is_attending = !rsvp.include?('not')
      !(want_attending ^ is_attending)
    end
    matching.map {|name, rsvp| name}
  end
end


class Party
  def email_to(address)
    @browser.open link + '.txt?email=' + address
    @browser.get_body_text
  end

  def rsvp_at(rsvp_link)
    @browser.open rsvp_link
  end
end

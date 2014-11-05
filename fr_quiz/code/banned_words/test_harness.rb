#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
require "filter"

class RQ9AlgorithmTest
  attr_accessor :words
  def initialize
    @words = []
  end
  
  def read_word_list(word_file)
    words = IO.readlines(word_file).map do |line|
      line.chomp
    end
    @words+= words
  end
  
  def test_algorithm(configuration, algorithm)
    banned_words = []
    words        = @words[0 .. configuration.words-1]
    if !configuration.rebuild_banned_words
      banned_words = words.sort_by{rand}[0 .. configuration.banned_words-1]
    end
    result = RQ9TestResult.new( configuration.words, configuration.banned_words,
                                configuration.rebuild_banned_words )
    configuration.runs.times do 
      if configuration.rebuild_banned_words
        banned_words = words.sort_by{rand}[0 .. configuration.banned_words-1]
      end
      result.add_run test_run(words,banned_words,algorithm)
    end
    result
  end
  
  def test_run(words, banned_words, algorithm)
    algorithm.words  = words
    filter           = LanguageFilter.new banned_words
    algorithm.filter = filter
    start_time       = Time.now
    result_words     = algorithm.run
    end_time         = Time.now
    
    result = RQ9TestRunResult.new( words.size, banned_words.size,
                                   filter.verify(result_words),
                                   end_time-start_time, filter.clean_calls )
  end
end

class RQ9TestRunConfiguration
  attr_accessor :words, :banned_words, :runs,:rebuild_banned_words
  def initialize(words = 3000, banned_words = 30, runs = 10,
                 rebuild_banned_words = true)
    @words                = words
    @banned_words         = banned_words
    @runs                 = runs
    @rebuild_banned_words = rebuild_banned_words 
  end
  
  def to_s
    "(#{@words},#{@banned_words},#{@runs},#{@rebuild_banned_words})"
  end
end

class RQ9TestRunResult
  attr_reader :words, :banned_words, :verified, :seconds, :mails
  def initialize(words, banned_words, verified, seconds, mails)
    @words        = words
    @banned_words = banned_words
    @verified     = verified
    @seconds      = seconds
    @mails        = mails
  end
  def to_s
    "       Words:  #{@words}\n"+
    "Banned Words:  #{@banned_words}\n"+
    "     Seconds:  #{@seconds}\n"+
    "       Mails:  #{@mails}\n"+
    (@verified ? "Verified\n" : "Failed\n")
  end
end

class RQ9TestResult
  attr_reader :words, :banned_words, :runcount,
              :rebuild_banned_words, :verified,
              :average_seconds, :average_mails
  def initialize(words, banned_words, rebuild_banned_words)
    @words                = words
    @banned_words         = banned_words
    @rebuild_banned_words = rebuild_banned_words
    @verified             = 0
    @average_seconds      = 0
    @average_mails        = 0
    @runs                 = []
  end
  
  def add_run(run)
    @runs << run
    @verified        = 0
    @average_seconds = 0
    @average_mails   = 0
    @runs.each do |run|
      @verified        += 1 if run.verified
      @average_seconds += run.seconds
      @average_mails   += run.mails
    end
    @average_seconds /= @runs.size
    @average_mails   /= @runs.size
  end
  
  def to_s
    "        Runs:  #{@runs.size}\n"+
    "       Words:  #{@words}\n"+
    "Banned Words:  #{@banned_words}\n"+
    "Average\n" +
    "     Seconds:  #{@average_seconds}\n"+
    "       Mails:  #{@average_mails}\n"+
    "    Verified:  #{@verified}/#{@runs.size}\n"+
    (@rebuild_banned_words ? "Rebuilt Banned Words\n":"")
  end
  
  def ext_to_s
    @runs.map { |run| run.to_s }.join("\n") + "\n\n" +
    to_s
  end
  
end

class RQ9Algorithm
  attr_accessor :words, :filter
  def run() end # return banned_words
end

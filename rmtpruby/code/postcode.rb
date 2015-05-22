#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "strscan"

class Postcode
  attr_reader :postcode, :area, :district, :outward, :inward

  def initialize(postcode)
    @postcode = String(postcode).strip.upcase
    @valid = false
    parse
  end

  def valid?
    @valid
  end

  def parse
    @scanner = StringScanner.new(postcode)

    if is_giro?
      @area = @outward = "GIR"
      @district = "IR"
      @inward   = "0AA"

      @valid = true
      return
    end

    @area = parse_area
    return unless @area

    @district = parse_district
    return unless @district

    @outward = @area + @district

    skip_whitespace

    @inward = parse_inward
    return unless @inward

    @valid = true
  end

  def to_s
    "#{outward} #{inward}"
  end

  private

  attr_reader :scanner

  def is_giro?
    scanner.scan(/GIR\s*0AA/)
  end

  def parse_area
    scanner.scan(/[A-PR-UWYZ][A-HK-Y]?/)
  end

  def parse_district
    if scanner.check(/[0-9][A-Z]/i)
      if @area.length == 1
        @district = scanner.scan(/[0-9][ABCDEFGHJKPSTUW]/)
      elsif @area.length == 2
        @district = scanner.scan(/[0-9][ABEHMNPRVWXY]/)
      end
    else
      @district = scanner.scan(/[0-9]{1,2}/)
    end
  end

  def parse_inward
    scanner.scan(/[0-9][ABD-HJLNP-UW-Z]{2}/)
  end

  def skip_whitespace
    scanner.skip(/\s+/)
  end
end

# Some example valid codes
["W1A 1AA", "sw100qj", "GIR 0AA", "se5 5aa"].each do |p|
  postcode = Postcode.new(p)
  fail unless postcode.valid?
  puts postcode
end

# Some example invalid codes
["WA1 AA1", "SW9Z 9ZZ", "Q44 4AA"].each do |p|
  postcode = Postcode.new(p)
  fail if postcode.valid?
end

#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
def get_week(file, week)
  file.seek((week - 1) * 63)

  week = {
    date:  file.read(10).strip,
    temps: {}
  }

  [:nino12, :nino3, :nino34, :nino4].each do |region|
    week[:temps][region] = {
      temp: file.read(9).to_f,
      change: file.read(4).to_f
    }
  end

  week
end

File.open("data/wksst8110.for") do |file|
  get_week(file, 3)
  # => {:date=>"17JAN1990",
  #     :temps=>
  #      {:nino12=>{:temp=>24.2, :change=>-0.3},
  #       :nino3=>{:temp=>25.3, :change=>-0.3},
  #       :nino34=>{:temp=>26.5, :change=>-0.1},
  #       :nino4=>{:temp=>28.6, :change=>0.3}}}
  get_week(file, 303)
  # => {:date=>"18OCT1995",
  #     :temps=>
  #      {:nino12=>{:temp=>20.0, :change=>-0.8},
  #       :nino3=>{:temp=>24.1, :change=>-0.9},
  #       :nino34=>{:temp=>25.8, :change=>-0.9},
  #       :nino4=>{:temp=>28.2, :change=>-0.5}}}
  get_week(file, 1303)
  # => {:date=>"17DEC2014",
  #     :temps=>
  #      {:nino12=>{:temp=>22.9, :change=>0.1},
  #       :nino3=>{:temp=>26.0, :change=>0.8},
  #       :nino34=>{:temp=>27.4, :change=>0.8},
  #       :nino4=>{:temp=>29.4, :change=>1.0}}}
end

#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
File.open("data/wksst8110.for") do |file|
  weeks = []

  until file.eof?
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

    file.read(1)

    weeks << week
  end

  weeks
  # => [{:date=>"03JAN1990",
  #      :temps=>
  #       {:nino12=>{:temp=>23.4, :change=>-0.4},
  #        :nino3=>{:temp=>25.1, :change=>-0.3},
  #        :nino34=>{:temp=>26.6, :change=>0.0},
  #        :nino4=>{:temp=>28.6, :change=>0.3}}},
  #     {:date=>"10JAN1990",
  #      :temps=>
  #       {:nino12=>{:temp=>23.4, :change=>-0.8},
  #        :nino3=>{:temp=>25.2, :change=>-0.3},
  #        :nino34=>{:temp=>26.6, :change=>0.1},
  #        :nino4=>{:temp=>28.6, :change=>0.3}}},
  #     {:date=>"17JAN1990",
  #      :temps=>
  #       {:nino12=>{:temp=>24.2, :change=>-0.3},
  #        :nino3=>{:temp=>25.3, :change=>-0.3},
  #        :nino34=>{:temp=>26.5, :change=>-0.1},
  #        :nino4=>{:temp=>28.6, :change=>0.3}}},
  # ...snip...
end


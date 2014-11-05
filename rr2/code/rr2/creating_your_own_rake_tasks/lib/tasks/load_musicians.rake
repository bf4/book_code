#START:simple_version
desc "Load musicians and the instruments they play into the database."
task :load_musicians => ['musicians.csv', :environment] do |t|
  before_count = Musician.count
  IO.readlines(t.prerequisites.first).each do |line|
    given_name, surname, instrument = line.split(/,/)
    Musician.create(:given_name => given_name, 
                    :surname => surname, 
                    :instrument => instrument)
  end
  puts "Loaded #{Musician.count - before_count} musicians."
end
#END:simple_version

#START:enhanced_version
desc "Load musicians and the instruments they play into the database.
task :load_musicians_enhanced => 
         ['musicians_with_column_names.csv', "db:migrate"] do |t|
  before_count = Musician.count
  lines = File.read(t.prerequisites.first).split("\n")
  # Strip white space
  attributes = lines.shift.split(/,/).collect{|name| name.strip}
  lines.each do |line|
    values = line.split(/,/)
    data = attributes.inject({}) do |hash,attribute|
      hash[attribute] = values.shift
      hash
    end
    Musician.create(data)
  end
  puts "Loaded #{Musician.count - before_count} musicians."
end
#END:enhanced_version

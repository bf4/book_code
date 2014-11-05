#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
hash = Hash.new {|h, k| h[k] = 0}
File.foreach(ARGV[0] || 'WORD.LST') do |line|
  line.strip!
  if line.size == 7
    letters = line.downcase.scan(/./).sort.join
    7.times do |i|
      hash[letters[0, i] + letters[(i+1)..-1]] |= 1 << (letters[i] - ?a)
    end
  end
end

cutoff = (ARGV[1] || '15').to_i
count = {}
hash.each do |k, v|
  v = (v & 0x5555555) + ((v>>1) & 0x5555555)
  v = (v & 0x3333333) + ((v>>2) & 0x3333333)
  v = (v & 0xf0f0f0f) + ((v>>4) & 0xf0f0f0f)
  v = (v & 0x0ff00ff) + ((v>>8) & 0x0ff00ff)
  v = (v & 0x000ffff) + ((v>>16) & 0x000ffff)
  count[k] = v if v >= cutoff
end

count.keys.sort_by {|k| count[k]}.each do |letters|
  printf "%s: (%d) ", letters, count[letters]
  combi = hash[letters]
  26.times do |i|
    print((i+?a).chr) if combi[i] == 1
  end
  puts
end

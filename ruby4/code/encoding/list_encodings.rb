#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
encodings = Encoding
              .list
              .each.with_object({}) do |enc, full_list|
                  full_list[enc.name] = [enc.name] 
               end

Encoding.aliases.each do |alias_name, base_name|
  fail "#{base_name} #{alias_name}" unless encodings[base_name]
  encodings[base_name] << alias_name
end

puts(encodings
      .values
      .sort_by {|base_name, *| base_name.downcase}
      .map do |base_name, *rest|
        if rest.empty?
          base_name
        else
          "#{base_name} (#{rest.join(', ')})"
        end
      end)
  

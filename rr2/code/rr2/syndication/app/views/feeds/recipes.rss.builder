

    xml.instruct!
    xml.rss "version" => "2.0",
              "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
      xml.channel do
        xml.title 'Freshly Added Recipes'
        xml.link recipes_url
        xml.pubDate CGI.rfc1123_date(@recipes.first.updated_at)
        xml.description h("Cook Book Freshly Added Recipes.")
        @recipes.each do |recipe|
          xml.item do
            xml.title recipe.title
            xml.link recipe_url(recipe)
            xml.description recipe.instructions
            xml.pubDate CGI.rfc1123_date(recipe.updated_at)
            xml.guid recipe_url(recipe)
            xml.author recipe.author.name
          end
        end
      end
    end

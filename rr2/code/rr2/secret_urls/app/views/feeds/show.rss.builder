    xml.instruct!
    xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
      xml.channel do
        xml.title 'Freshly Added Questions'
        xml.link ""
        xml.pubDate CGI.rfc1123_date(@inbox.messages.first.created_at)
        xml.description "Freshly Added Questions In Need of Answers."
        @inbox.messages.each do |message|
          xml.item do
            xml.title message.title
            xml.link "http://cnn.com"
            xml.description h(message.body)
            xml.pubDate CGI.rfc1123_date(message.created_at)
            xml.guid message.id
            xml.author h(message.sender.name)
          end
        end
      end
    end

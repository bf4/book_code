#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
module CreationsHelper
  # The standard reference line for a creation
  # Includes name, stage, revision, and format
  def creation_reference(creation)
    padded_revision = 'r%04d' % creation.revision
    link = link_to(creation.name,
                   creation,
                   title: "More info on #{creation.name}")
    raw("#{link} (#{creation.stage}, #{padded_revision},
         #{creation.format.upcase})")
  end
end

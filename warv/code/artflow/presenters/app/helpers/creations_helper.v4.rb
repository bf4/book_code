#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
module CreationsHelper

  def creation_thumbnail(creation)
    if creation.default_image?
      image_tag(creation.default_image, alt: creation.name)
    else
      image_tag("missing_creation.png", alt: "No image for this creation")
    end
  end

  def creation_reference(creation)
    padded_revision = 'r%04d' % creation.revision
    link = link_to(creation_thumbnail(creation),
                   creation,
                   title: "More info on #{creation.name}")
    raw("#{link} (#{creation.stage},
         #{padded_revision}, #{creation.format.upcase})")
  end

end

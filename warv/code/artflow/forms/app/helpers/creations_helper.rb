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
      image_tag("missing_creation.png",
                alt: "No image for this creation")
    end
  end
  
  def creation_reference(creation)
    padded_revision = 'r%04d' % creation.revision
    link = link_to(creation_thumbnail(creation),
                   creation,
                   title: "More info on #{creation.name}")
    size = number_to_human_size(creation.filesize)
    raw("#{link} (#{size}, #{creation.stage},
        #{padded_revision}, #{creation.format.upcase})")
  end

  def creation_client_name(creation = @creation)
    creation.project.client.name
  end

  def controls_for_creation(creation)
    if current_user.manages?(creation)
      partial = controls_partial_for_creation(creation)
      contents = render(partial: partial,
                        locals: {creation: creation})
      content_tag(:ul, contents, class: 'controls')
    end
  end

  def controls_partial_for_creation(creation)
    if current_user.admin?
      'creations/controls/admin'
    elsif current_user.editor?
      'creations/controls/editor'
    elsif current_user.authored?(creation)
      'creations/controls/author'
    elsif current_user.shares?(creation)
      'creations/controls/collaborator'
    end
  end

  def show_preview?(creation)
    creation.thumbnail? &&
      current_user.can_view?(creation) &&
        expanded_view?
  end

  def expanded_view?
    session[:view] == 'expanded'
  end

  def previewing(creation)
    yield if show_preview?(creation)
  end

  def switching_creation_tag_for(creation, &block)
    content_tag_for(:li, creation, class: creation.file_type, &block)
  end

  def ad_dimensions_tag(builder)
    options = grouped_options_for_select(ad_dimensions_options,
                                          builder.object.ad_dimensions)
    select_tag('creation[ad_dimensions]', options)
  end

  def ad_dimensions_options
    [
     ['Print',
       ['legal', 'letter', 'half letter', 'half legal', 'other print']],
     ['Web',
       ['full banner', 'half banner', 'vertical banner', 'button']]
    ]
  end
  
end

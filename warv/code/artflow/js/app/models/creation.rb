#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class Creation < ActiveRecord::Base
  has_attached_file :file, styles: {
    thumbnail:  "100x100#",
    small:      "150x150>",
    medium:     "200x200"
  }
  belongs_to :client
  belongs_to :project
  belongs_to :designer
  has_many :comments

  validates :name, :description,
            :project_id, presence: true

  validates :name, :description, :project_id, presence: true

  before_validation :copy_client_id, on: :create

  def title
    name
  end
  
  def default_image?
    file.exists?
  end

  def default_image
    file.url(:thumbnail)
  end

  def thumbnail?
    file.exists?
  end
  
  def approvable?
    status == 'awaiting_approval'
  end

  def file_type
    file.content_type
  end

  private

  def copy_client_id
    write_attribute(:client_id, project.client_id)
  end

end

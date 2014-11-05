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
  belongs_to :estimate
  belongs_to :client
  belongs_to :project
  belongs_to :designer
  has_many :comments

  validates :name, :description,
            :project_id, :estimate_id, presence: true

  validates :name, :description, :project_id, presence: true

  delegate :campaign, to: :project

  scope :active, conditions: 'status != "completed"'
  scope :pending_approval, conditions: {status: 'awaiting_approval'}
  scope :approved, conditions: {status: 'approved'}
  
  before_validation :copy_client_id, on: :create
  before_validation :generate_blank_estimate, on: :create
  
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

  def approve
    self.status = 'approved'
  end

  private

  def copy_client_id
    write_attribute(:client_id, project.client_id)
  end

  def generate_blank_estimate
    unless estimate
      self.estimate = Estimate.create
    end
  end

end

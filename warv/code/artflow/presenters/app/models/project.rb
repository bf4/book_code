#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class Project < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :client
  has_many :creations, dependent: :destroy
  has_many :assignments, class_name: 'ProjectAssignment'
  has_many :designers, through: :assignments
  
  validates :name, presence: true
  validates :client_id, presence: true

  before_validation :copy_client_id, on: :create
  
  scope :active, where(active: true)

  def self.total_hours
    all.map(&:total_hours).sum
  end
  
  def total_hours
    creations.sum(:hours)
  end
  
  private

  def copy_client_id
    write_attribute(:client_id, campaign.client_id)
  end

end

#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class Designer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  has_many :assignments, class_name: 'ProjectAssignment'
  has_many :projects, through: :assignments
  has_many :creations

  scope :active, conditions: {active: true}

  # NOTE: We stub out the authorization of creations so that you
  # can easily run the example code discussed in the chapters.
  #
  # In a real, full fledged application we'd use cancan or another
  # authorization-providing library. 
  def manages?(creation)
    true
  end

  def can_view?(creation)
    true
  end

  # NOTE: We stub out authorization so that you
  # can easily run the example code discussed in the chapters.
  #
  # In a real, full fledged application we'd use cancan or another
  # authorization-providing library.
  def admin?
    true
  end

  def designer?
    true
  end
  
end

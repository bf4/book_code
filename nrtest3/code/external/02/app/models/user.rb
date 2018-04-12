#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  #
  has_many :roles, dependent: :destroy
  has_many :projects, through: :roles
  has_many :tasks, dependent: :nullify
  #

  #
  def can_view?(project)
    project.in?(visible_projects)
  end
  #

  #
  def visible_projects
    return Project.all if admin?
    Project.where(id: project_ids).or(Project.all_public)
  end
  #

  #
  def avatar_url
    adapter = AvatarAdapter.new(self)
    adapter.image_url
  end
  #
end

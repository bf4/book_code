#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class UserPolicy

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def same_user?
    user == record
  end

  def show?
    same_user? || user.admin?
  end

  def update?
    same_user? || user.admin?
  end

  def edit?
    same_user? || user.admin?
  end

  def simulate?
    user.admin? && !same_user?
  end

end

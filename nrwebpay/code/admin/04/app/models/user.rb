#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class User < ApplicationRecord

  has_paper_trail ignore: %i(sign_in_count current_sign_in_at last_sign_in_at)

  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :validatable

  enum role: {user: 0, vip: 1, admin: 2}

  has_many :tickets
  has_many :subscriptions

  #
  def tickets_in_cart
    tickets.waiting.all.to_a
  end
  #

  def subscriptions_in_cart
    subscriptions.waiting.all.to_a
  end

end

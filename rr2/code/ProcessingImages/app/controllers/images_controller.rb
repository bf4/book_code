#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ImagesController < ApplicationController

  def new
	  @images = Image.find :all
	  @image = Image.new
  end
	
	def create
	  @image = Image.create(params[:image])
		redirect_to :action => 'new'
	end
	
	def clean
	  Image.destroy_all
		redirect_to :action => 'new'
	end
	
end

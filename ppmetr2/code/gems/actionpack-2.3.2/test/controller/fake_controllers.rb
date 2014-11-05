#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class << Object; alias_method :const_available?, :const_defined?; end
  
class ContentController < Class.new(ActionController::Base)
end
class NotAController
end
module Admin
  class << self; alias_method :const_available?, :const_defined?; end
  class UserController < Class.new(ActionController::Base); end
  class NewsFeedController < Class.new(ActionController::Base); end
end

# For speed test
class SpeedController < ActionController::Base;  end
class SearchController        < SpeedController; end
class VideosController        < SpeedController; end
class VideoFileController     < SpeedController; end
class VideoSharesController   < SpeedController; end
class VideoAbusesController   < SpeedController; end
class VideoUploadsController  < SpeedController; end
class VideoVisitsController   < SpeedController; end
class UsersController         < SpeedController; end
class SettingsController      < SpeedController; end
class ChannelsController      < SpeedController; end
class ChannelVideosController < SpeedController; end
class SessionsController      < SpeedController; end
class LostPasswordsController < SpeedController; end
class PagesController         < SpeedController; end

ActionController::Routing::Routes.draw do |map|
  map.route_one 'route_one', :controller => 'elsewhere', :action => 'flash_me'
  map.connect ':controller/:action/:id'
end

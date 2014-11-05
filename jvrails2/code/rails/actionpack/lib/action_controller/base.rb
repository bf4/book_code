#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module ActionController
  class Base < Metal
    abstract!

    include AbstractController::Layouts
    include AbstractController::Translation
    include AbstractController::AssetPaths
    include Helpers
    include HideActions
    include UrlFor
    include Redirecting
    include Rendering
    include Renderers::All
    include ConditionalGet
    include RackDelegation
    include Caching
    include MimeResponds
    include ImplicitRender
    include StrongParameters
    include Cookies
    include Flash
    include RequestForgeryProtection
    include ForceSSL
    include Streaming
    include DataStreaming
    include RecordIdentifier
    include HttpAuthentication::Basic::ControllerMethods
    include HttpAuthentication::Digest::ControllerMethods
    include HttpAuthentication::Token::ControllerMethods
    include AbstractController::Callbacks
    include Rescue
    include Instrumentation
    include ParamsWrapper

    ActiveSupport.run_load_hooks(:action_controller, self)
  end
end

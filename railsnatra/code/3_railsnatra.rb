require "active_support"
require "action_controller"
require "action_controller/base"

class Railsnatra < ActionController::Base
  class_attribute :inline_routes
  self.inline_routes = Hash.new { |h,k| h[k] = [] }

  class << self
    def get(path, &block)
      define_route("GET", path, block)
    end

    def post(path, &block)
      define_route("POST", path, block)
    end

    def put(path, &block)
      define_route("PUT", path, block)
    end

    def delete(path, &block)
      define_route("DELETE", path, block)
    end

    def patch(path, &block)
      define_route("PATCH", path, block)
    end

    private

    def define_route(verb, path, block)
      current  = inline_routes[verb] || []
      current += [[path, block]]
      self.inline_routes = inline_routes.merge(verb => current)
    end
  end

  def self.call(env)
    action(:railsnatra).call(env)
  end

  def railsnatra
    unless run_inline_route
      not_found
    end

    raise "inline route did not redirect nor render" unless performed?
  end

  include ActionView::Context
  before_filter :_prepare_context

  private

  def view_context
    self
  end

  def run_inline_route
    inline_routes[request.request_method].each do |path, block|
      if request.path_info == path
        instance_exec(&block)
        return true
      end
    end
    false
  end

  def not_found
    headers["X-Cascade"] = "pass"
    self.response_body   = ""
  end
end

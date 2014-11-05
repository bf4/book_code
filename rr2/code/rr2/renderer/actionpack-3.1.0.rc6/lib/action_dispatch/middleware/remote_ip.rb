#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionDispatch
  class RemoteIp
    class IpSpoofAttackError < StandardError ; end

    class RemoteIpGetter
      def initialize(env, check_ip_spoofing, trusted_proxies)
        @env = env
        @check_ip_spoofing = check_ip_spoofing
        @trusted_proxies = trusted_proxies
      end

      def remote_addrs
        @remote_addrs ||= begin
          list = @env['REMOTE_ADDR'] ? @env['REMOTE_ADDR'].split(/[,\s]+/) : []
          list.reject { |addr| addr =~ @trusted_proxies }
        end
      end

      def to_s
        return remote_addrs.first if remote_addrs.any?

        forwarded_ips = @env['HTTP_X_FORWARDED_FOR'] ? @env['HTTP_X_FORWARDED_FOR'].strip.split(/[,\s]+/) : []

        if client_ip = @env['HTTP_CLIENT_IP']
          if @check_ip_spoofing && !forwarded_ips.include?(client_ip)
            # We don't know which came from the proxy, and which from the user
            raise IpSpoofAttackError, "IP spoofing attack?!" \
              "HTTP_CLIENT_IP=#{@env['HTTP_CLIENT_IP'].inspect}" \
              "HTTP_X_FORWARDED_FOR=#{@env['HTTP_X_FORWARDED_FOR'].inspect}"
          end
          return client_ip
        end

        return forwarded_ips.reject { |ip| ip =~ @trusted_proxies }.last || @env["REMOTE_ADDR"]
      end
    end

    def initialize(app, check_ip_spoofing = true, trusted_proxies = nil)
      @app = app
      @check_ip_spoofing = check_ip_spoofing
      regex = '(^127\.0\.0\.1$|^(10|172\.(1[6-9]|2[0-9]|30|31)|192\.168)\.)'
      regex << "|(#{trusted_proxies})" if trusted_proxies
      @trusted_proxies = Regexp.new(regex, "i")
    end

    def call(env)
      env["action_dispatch.remote_ip"] = RemoteIpGetter.new(env, @check_ip_spoofing, @trusted_proxies)
      @app.call(env)
    end
  end
end
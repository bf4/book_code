#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionWebService # :nodoc:
  module Protocol # :nodoc:
    module Discovery # :nodoc:
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, ActionWebService::Protocol::Discovery::InstanceMethods)
      end

      module ClassMethods # :nodoc:
        def register_protocol(klass)
          write_inheritable_array("web_service_protocols", [klass])
        end
      end

      module InstanceMethods # :nodoc:
        private
          def discover_web_service_request(action_pack_request)
            (self.class.read_inheritable_attribute("web_service_protocols") || []).each do |protocol|
              protocol = protocol.create(self)
              request = protocol.decode_action_pack_request(action_pack_request)
              return request unless request.nil?
            end
            nil
          end

          def create_web_service_client(api, protocol_name, endpoint_uri, options)
            (self.class.read_inheritable_attribute("web_service_protocols") || []).each do |protocol|
              protocol = protocol.create(self)
              client = protocol.protocol_client(api, protocol_name, endpoint_uri, options)
              return client unless client.nil?
            end
            nil
          end
      end
    end
  end
end

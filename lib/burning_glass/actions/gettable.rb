require 'plural'

module BurningGlass
  module Actions
    module Gettable

      def get_by(method_name, params={})
        prepended_name = "get_by_#{method_name}".to_sym

        define_singleton_method(prepended_name) do |id|
          response = deliver_request(:get, "#{resource_name.to_s.plural}/#{id}")
          parse_singular_resource(response['data'])
        end
      end

    end
  end
end

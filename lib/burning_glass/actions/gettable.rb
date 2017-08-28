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

      def get_by_criteria(criteria_name)
        accepted_parameters = constantize(
          "BurningGlass::Criteria::#{criteria_name.capitalize}"
        ).accepted_parameters

        define_singleton_method(:get) do |params={}|
          params.select!{ |k,v| accepted_parameters.include?(k.to_s) }
          response = deliver_request(:get, "#{resource_name.to_s.plural}", params)
          parse_multiple_resources(response['data'])
        end

      end

    end
  end
end

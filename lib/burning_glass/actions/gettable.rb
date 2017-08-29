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

      def get_by_criteria(*criteria_name)
        accepted_params = merge_criteria_params(criteria_name)

        define_singleton_method(:get) do |params={}|
          validate_and_filter_params!(accepted_params, params)

          response = deliver_request(:get, "#{resource_name.to_s.plural}", params)
          parse_multiple_resources(response['data'])
        end

      end

      private

      def validate_and_filter_params!(accepted_params, params)
        required_params = accepted_params.select{ |p| p[0] == '!' }
        true_name_requirements = (required_params || []).map{ |p| p[1..-1] }
        missing_reqs = true_name_requirements.select{ |req| !params.keys.include?(req.to_sym) }

        if missing_reqs.empty?
          accepted_params.concat(true_name_requirements)
          params.select!{ |k,v| accepted_params.include?(k.to_s) }
        else
          raise Error.new("Required parameters for this request missing (#{missing_reqs.join(" ")})")
        end
      end

      def merge_criteria_params(criteria_names)
        criteria_names.inject([]) do |summ, c_name|
          critera_acceptance = constantize(
            "BurningGlass::Criteria::#{camelize(c_name.to_s)}"
          ).accepted_parameters

          summ.concat(critera_acceptance)
          summ
        end
      end

    end
  end
end

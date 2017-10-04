require 'plural'

module BurningGlass
  module Actions
    module Gettable

      def get_by(method_name, definition_params={})
        prepended_name = "get_by_#{method_name}".to_sym

        define_singleton_method(prepended_name) do |id, params={}|
          response = deliver_request(:get, "#{resource_name.to_s.plural}/#{id}", params)
          parse_singular_resource(response['data'])
        end
      end

      def get_by_criteria(*criteria_name)
        accepted_params = merge_criteria_params(criteria_name)

        method = accepted_params[:options][:method] || :get
        resource_path = accepted_params[:options][:path] || 'data'

        singleton_name = determine_criteria_method_name(criteria_name)

        define_singleton_method(singleton_name) do |params={}|
          validate_and_filter_params!(accepted_params[:acceptance], params)

          response = deliver_request(method, "#{resource_name.to_s.plural}", params)
          returned_resource = resource_path.is_a?(Array) ? dig(response, resource_path) : response[resource_path]

          parse_multiple_resources(returned_resource)
        end

      end

      private

      def determine_criteria_method_name(criteria_name)
        if methods.include?(:get)
          ('get_by_' + criteria_name.join("_and_")).to_sym
        else
          :get
        end
      end

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
        criteria_names.inject({acceptance: [], options: {}}) do |summ, c_name|
          if c_name.is_a?(Hash)
            summ[:options].merge!(c_name)
          else
            critera_acceptance = constantize(
              "BurningGlass::Criteria::#{camelize(c_name.to_s)}"
            ).accepted_parameters

            summ[:acceptance].concat(critera_acceptance)
          end
          summ
        end
      end

      def dig(resource_body, path)
        path.inject(resource_body) do |summ, p|
          summ = summ[p]
          summ
        end
      end

    end
  end
end

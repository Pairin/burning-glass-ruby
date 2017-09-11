require 'plural'

module BurningGlass
  module Actions
    module Relatable

      def has_many(method_name, opts={})
        define_relational_method(method_name)
      end

      def belongs_to(parent_name, params={})
        prepended_name = "get_by_#{parent_name}_id".to_sym
        
        url_path = "#{parent_name.to_s.plural}/:id/#{params[:resource_name] || resource_name.plural}"

        finders = ['data'].concat(params[:resource_key] || [])

        define_singleton_method(prepended_name) do |id, params={}|
          response = deliver_request(:get, url_path.gsub(":id", id.to_s), params)
          data = finders.inject(response) do |summ, f|
            summ = summ[f]
            summ
          end

          parse_multiple_resources(data)
        end
      end

    end
  end
end

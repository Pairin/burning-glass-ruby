module BurningGlass
  module Explorer
    class ExplorerResource < APIResource
      URL_BASE = '/v207/explorer/'.freeze
      RELATIONAL_VALUE_REGEX = /(\/[a-z]+\/[0-9]+\/[a-z]+)/

      extend Actions::Gettable
      extend Actions::Relatable

      class << self

        def url_base
          URL_BASE
        end

        def parse_singular_resource(resource_data)
          new(resource_data)
        end

        def parse_multiple_resources(resources_data)
          resources_data.map{ |rd| parse_singular_resource(rd) }
        end

        def relational_value?(method_value)
          method_value.is_a?(String) && method_value.match(RELATIONAL_VALUE_REGEX)
        end

        def define_relational_method(name, value=nil)

          define_method(name) do
            klass_name = singularize(name).capitalize
            module_names = self.class.name.split("::")
            module_names.pop
            module_names << klass_name

            klass_name = module_names.join("::")

            begin
              klass = constantize(camelize(klass_name))
              instance_name = "@#{name}"
              instance_variable_get(instance_name) || instance_variable_set("@#{name}", klass.get_by_occupation_id(integer_id))
            rescue NameError
              value
            end
          end
        end

      end

      def initialize(data={})
        set_accessors(data)
      end

      def integer_id
        id.scan(/[0-9]+/).first
      end

      private

      def metaclass
        class << self; self; end
      end

      def set_accessors(data)
        data.each do |(k,v)|
          metaclass.instance_eval do
            method_name = underscore(k)

            if relational_value?(v)
              method_value = define_relational_method(method_name, v)
            else
              define_method(method_name) { v }
            end
          end
        end
      end

    end
  end
end

module BurningGlass
  module Util
    class StringHelper

      class << self

        def constantize(string)
          Object.const_get(string)
        end

        def hash_to_query_string(params)
          params.map do |k, v|
            "#{k}=#{v}"
          end.join("&")
        end

      end

    end
  end
end

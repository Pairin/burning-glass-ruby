module BurningGlass
  module Util
    class StringHelper

      class << self

        def constantize(string)
          Object.const_get(string)
        end

      end

    end
  end
end

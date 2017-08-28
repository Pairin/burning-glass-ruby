module BurningGlass
  module Insight
    class InsightResource < APIResource

      URL_BASE = '/v205/insight/'.freeze

      class << self

        def url_base
          URL_BASE
        end

      end
      
    end
  end
end

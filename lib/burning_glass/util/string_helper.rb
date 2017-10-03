module BurningGlass
  module Util
    module StringHelper

      def constantize(string)
        Object.const_get(string)
      end

      def hash_to_query_string(params)
        params.map do |k, v|
          if v.is_a?(Hash)
            v.map do |sk, sv|
              "#{k}[#{sk}]=#{sv}"
            end.join("&")
          else
            "#{k}=#{v}"
          end
        end.join("&")
      end

      def underscore(string)
        string.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
      end

      def camelize(string, uppercase_first_letter=true)
        if uppercase_first_letter
          string = string.sub(/^[a-z\d]*/) { $&.capitalize }
        else
          string = string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { $&.downcase }
        end
        string.gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.gsub('/', '::')
      end

      def singularize(string)
        case string
        when /\A(.*)ies\z/
          $1 + 'y'
        when /\A(.*)s\z/
          $1
        end
      end

    end
  end
end

require 'cgi/html'

module Grocerly

  module Html

    class Base

      attr_reader :data

      def initialize(unsafe_data = {})
        @data = escape_enum(unsafe_data)
      end

      def cgi
        CGI::HTML5.new
      end

      def escape(val)
        CGI.escapeHTML(val)
      end

      alias_method :e, :escape

      # This is quite ugly to me, in reality I'd spend more time doing it more neatly
      def escape_enum(enum)
        arry = enum.map do |k, v|

          value = v || k

          if value.kind_of? String
            enum.kind_of?(Hash) ? [k, escape(value)] : escape(value)
          elsif value.respond_to? :each
            enum.kind_of?(Hash) ? [k, escape_enum(value)] : escape_enum(value)
          end

        end

        if enum.kind_of? Hash
          Hash[arry]
        else
          arry.compact.flatten
        end
      end

      # this choice makes it easier to pass in something more generic, such as alambda instead of a Header object
      def call
        _generate
      end

      private

      def _escape_hash
        if value.kind_of? String
          value = escape(value)
        elsif value.respond_to? :each
          value = escape_enum(value)
        end
      end

      def _escape_arry

      end

      def _generate
        raise NotImplementedError, "Define _generate as a private method in your subclass!"
      end

    end

  end

end

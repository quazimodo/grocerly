require 'cgi/html'

module Grocerly

  module Html

    class Base

      attr_reader :unsafe_data

      def initialize(unsafe_data = {})
        @unsafe_data = unsafe_data
      end

      def cgi
        CGI::HTML5.new
      end

      def escape(val)
        CGI.escapeHTML(val)
      end

      alias_method :h, :escape

      def strip_unsafe(str)
        str.gsub(/[^0-9a-z ]/i, '')
      end

      # This is quite ugly to me, in reality I'd spend more time doing it more
      # neatly. I left it here as an artefact of a thought process.
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

      # this choice makes it easier to pass in something more generic to the
      # context that uses these html generating strategies, such as a lambda
      # instead of a Header object
      def call
        _generate
      end

    private

      def _generate

        raise NotImplementedError,
          "Define _generate as a private method in your subclass!"

      end

    end

  end

end

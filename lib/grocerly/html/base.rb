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

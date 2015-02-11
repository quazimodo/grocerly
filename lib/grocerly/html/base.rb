require 'cgi/html'


module Grocerly

  module Html

    class Base

      def cgi
        CGI::HTML5.new
      end

      def escape_hash(hash)
        ary = hash.map do |k, v|
          [k, CGI.escapeHTML(v) ]
        end
        Hash[ary]
      end

      # this choice makes it easier to pass in something more generic, such as alambda instead of a Header object
      def call
        _generate
      end

      private

      def _generate
        raise NotImplementedError, "Define _generate as a private method in your subclass!"
      end

    end

  end

end

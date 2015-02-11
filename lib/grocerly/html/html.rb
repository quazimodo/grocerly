require 'grocerly/html/base'

module Grocerly

  module Html

    class Html < Base

      def initialize(header:, navbar:, body:, pagination: lambda {""})

        @header = header
        @navbar = navbar
        @pagination = pagination
        @body = body

      end

    private

      def _generate

        cgi.html("PRETTY" => "  ") do
          @header.call +

          cgi.body do

            @navbar.call +
            @pagination.call +
            @body.call +
            @pagination.call +
            cgi.script(src: "https://code.jquery.com/jquery-2.1.3.min.js") +
            cgi.script(src: "http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js")

          end
        end

      end
    end
  end
end


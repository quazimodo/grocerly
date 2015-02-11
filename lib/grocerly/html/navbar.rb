require 'grocerly/html/base'

module Grocerly

  module Html

    class Navbar < Base

      def initialize(unsafe_data = {})
        super
        @retailers = unsafe_data.fetch(:retailers, [])
      end

      private

      def _generate

        cgi.nav do
          cgi.div(class: "container-fluid") do

            cgi.div(class: "navbar-header") do
              cgi.button(type: "button",
                         class: "navbar-toggle collapsed",
                         "data-toggle" => "collapse",
                         "data-target" => "#main-navbar") do
                cgi.span(class: "sr-only") { "Toggle Navigation" } +

                cgi.span(class: "icon-bar") +
                  cgi.span(class: "icon-bar") +
                  cgi.span(class: "icon-bar")
              end +
                cgi.a(class: "navbar-brand", href: "#") { "Grocerly" }
            end +

            cgi.div(class: "collapse navbar-collapse", id: "main-navbar") do
              cgi.ul(class: "nav navbar") do
                cgi.li { cgi.a(href: "/index.html") { "Index" } } +
                  @retailers.map do |ret|
                  cgi.li { cgi.a(href: "/#{ret}/index.html") { "#{ret}" } }
                end.compact.join("")
              end
            end

          end
        end
      end
    end
  end
end

require 'grocerly/html/base'

module Grocerly

  module Html

    class Pagination < Base

      def initialize(unsafe_data = {})
        super
        @page  = unsafe_data.fetch(:page, 1)
        @pages = unsafe_data.fetch(:pages, 1)
        @base_path = unsafe_data.fetch(:base_path, "/")
      end

    private

      def _generate

        cgi.div(class: "container") do
          cgi.div(class: "row") do
            cgi.div(class: "col-sm-4 col-sm-offset-1") do
              cgi.nav do
                cgi.ul(class: "pagination") do

                  _first +
                  _previous(@page - 1) +
                  _previous(@page) +
                  _current +
                  _next(@page) +
                  _next(@page + 1) +
                  _last

                end
              end
            end
          end
        end

      end

      def _first

        cgi.li do
          cgi.a(href: "#{@base_path}/index.html") { cgi.span { "&laquo;" } }
        end

      end

      def _previous(page)

        if (page - 1) > 0

          page_name = page == 2 ? "index.html" : "index-page-#{page-1}.html"
          link = "#{@base_path}/#{page_name}"

          cgi.li do
            cgi.a(href: link) { page - 1 }
          end
        else
          ""
        end

      end

      def _current

        cgi.li(class: "active") do
          cgi.a(href: "#") { @page }
        end

      end

      def _next(page)

        if (page + 1) <= @pages
          link = "#{@base_path}/index-page-#{page+1}.html"

          cgi.li do
            cgi.a(href: link) { page+1 }
          end
        else
          ""
        end

      end

      def _last

        cgi.li do
          if @pages == 1
            cgi.a(href: "#{@base_path}/index.html") { cgi.span { "&raquo;" } }
          else
            cgi.a(href: "#{@base_path}/index-page-#{@pages}.html") { cgi.span { "&raquo;" } }
          end
        end

      end
    end
  end
end


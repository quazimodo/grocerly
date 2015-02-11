require 'grocerly/html/base'

module Grocerly

  module Html

    class Body < Base

      NCOLS = 5

      def initialize(unsafe_data = {})
        super
        @products = Array.new unsafe_data.fetch(:products, [])
        @nproducts = @products.count
        @nrows = @nproducts / NCOLS
        @nrows +=  @nproducts % NCOLS != 0 ? 1 : 0
      end

      private

      def _bootstrap_thumbnail(obj)

        src = obj.fetch("image", "http://placehold.it/48x48")
        name = obj.fetch("name", "No Name")
        retailer = obj.fetch("retailer", "No Retailer")
        price = obj.fetch("price", "Not Priced")

        cgi.div(class: "thumbnail") do

          (src = obj["image"] ? cgi.img(src: src, alt: "image for #{name}") : "") +

          cgi.div(class: "caption") do

            cgi.h3 { h name } +
              cgi.h4 { "$ #{h price.to_s}" } +
              cgi.p { h retailer }

          end
        end
      end


      def _generate

        cgi.div(class: "container") do

          if @nrows == 0
            cgi.h2 { "No Products" }
          else
            @nrows.times.map do

              cgi.div(class: "row") do

                cgi.div(class: ".col-sm-2 .col-sm-offset-1") do
                  obj = @products.pop
                  _bootstrap_thumbnail obj
                end +

                (NCOLS-1).times.map do

                obj = @products.pop

                cgi.div(class: ".col-sm-2") do
                  _bootstrap_thumbnail obj
                end

              end.compact.join
              end

            end.compact.join

          end

        end
      end
    end
  end
end

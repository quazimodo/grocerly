require 'grocerly/html/base'

module Grocerly

  module Html

    class Body < Base

      NCOLS = 5

      def initialize(unsafe_data = {})
        super
        @products = unsafe_data.fetch(:products, [])
        @nproducts = @products.count
        @nrows = @nproducts / NCOLS
      end

      private

      def _bootstrap_thumbnail(obj)
        name = obj.fetch("name", "No Name")
        price = obj.fetch("price", "Not Priced")

        cgi.div(class: "thumbnail") do

          (src = obj["image"] ? cgi.img(src: src, alt: "image for #{name}") : "") +

          cgi.div(class: "caption") do

            cgi.h3 { h name } +
              cgi.h4 { "$ #{h price.to_s}" }

          end
        end
      end


      def _generate

        cgi.div(class: "container") do

          @nrows.times.map do

            cgi.div(class: "row") do

              NCOLS.times.map do
                obj = @products.pop
                cgi.div(class: ".col-sm-2") do

                  _bootstrap_thumbnail obj

                end

              end.compact.join
            end



          end
        end
      end
    end
  end
end

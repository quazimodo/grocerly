require 'optparse'
require 'cgi'
require 'fileutils'

require 'grocerly/html/html'
require 'grocerly/html/header'
require 'grocerly/html/navbar'
require 'grocerly/html/body'
require 'grocerly/html/pagination'
require 'grocerly/json_parser'
require 'grocerly/paginator'

module Grocerly

  class Main

    attr_reader :input, :output

    def run(args)

      _parse_opts(args)
      _create_dirs
      _create_index
      _create_retailers

    end

  private

    def _create_retailers

      _retailers.each do |retailer|

        paginated_products = Grocerly::Paginator.new _product_list.find_by_retailer(retailer), 20
        pages = paginated_products.pages

        pages.times.with_index do |idx|
          page = idx + 1

          title = idx == 0 ? "#{retailer}" : "#{retailer} - Page #{page}"
          products = paginated_products.page(page)

          html = _page_html(products: products, title: title,
                            page: page, pages: pages, base_path: "/#{_strip_unsafe retailer}")
          if idx == 0
            file_path = "#{@output}/#{_strip_unsafe retailer}/index.html"
          else
            file_path = "#{@output}/#{_strip_unsafe retailer}/index-page-#{page}.html"
          end

          file = File.new file_path, "w"
          file << html
          file.close

        end

      end
    end

    def _strip_unsafe(str)
      str.gsub(/[^0-9a-z ]/i, '')
    end

    def _create_index

      paginated_products = Grocerly::Paginator.new _product_list.data, 20
      pages = paginated_products.pages

      pages.times.with_index do |idx|
        page = idx + 1

        title = idx == 0 ? "Index" : "Index - Page #{page}"
        products = paginated_products.page(page)

        html = _page_html(products: products, title: title,
                          page: page, pages: pages, base_path: "")

        file_path = idx == 0 ? "#{@output}/index.html" : "#{@output}/index-page-#{idx+1}.html"

        f = File.new file_path, "w"
        f << html
        f.close

      end

    end

    def _create_dirs

      dirs = [@output]
      _retailers.each { |retailer| dirs << "#{@output}/#{_strip_unsafe retailer}/" }
      FileUtils.mkdir_p dirs

    end

    def _retailers
      _product_list.retailers
    end

    def _page_html(products:, title:, page:, pages:, base_path:)

      header = Grocerly::Html::Header.new title: title
      body = Grocerly::Html::Body.new products: products
      pagination = Grocerly::Html::Pagination.new page: page, pages: pages, base_path: base_path
      html = Grocerly::Html::Html.new header: header, navbar: _navbar, body: body, pagination: pagination

      html.call

    end

    def _navbar
      @navbar ||= Grocerly::Html::Navbar.new retailers: _product_list.retailers
    end

    def _product_list

      json_data = JsonParser.new _json
      @product_list ||= json_data.parse

    end

    def _json
      File.open @input do |file|
        file.read
      end
    end

    def _parse_opts(args)

      optparse = OptionParser.new do |opts|
        opts.default_argv = args
        opts.banner = "Usage: grocerly -i /path/to/input.json -o /path/to/output/dir/"

        opts.on("-i", "--input [INPUT]", "Specify input file directory") do |i|
          @input = i
        end

        opts.on("-o", "--output [OUTPUT]", "Specify output directory") do |o|
          @output = o
        end

        opts.on('-h', '--help', 'Displays Help') do
          puts opts
          exit
        end

      end.parse!

      mandatory = [:input, :output]

      missing = mandatory.select{ |opt| self.send(opt).nil? }
      if not missing.empty?
        puts "Missing options: #{missing.join(', ')}"
        puts optparse
        exit
      end
    end

  end

end

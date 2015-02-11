require 'optparse'
require 'cgi'
require 'fileutils'

require 'grocerly/html/html'
require 'grocerly/html/header'
require 'grocerly/html/navbar'
require 'grocerly/html/body'
require 'grocerly/json_parser'
require 'grocerly/paginator'

module Grocerly

  class Main

    attr_reader :input, :output

    def run
      _parse_opts
      _create_dirs
      _create_index
      _create_retailers
    end

    #  ;    1 get retailer        #
    # 2 get all products
    # 3 paginate products arry
    # for n pages in arry
    #   create retailer file arry.page(n)
    # end

    # index
    # get all products
    # paginate producst arry

    private

    def _create_retailers
      _retailers.each do |retailer|

        paginated_products = Grocerly::Paginator.new _product_list.find_by_retailer(retailer), 20
        paginated_products.pages.times.with_index do |idx|

          title = idx == 0 ? "#{retailer}" : "#{retailer} - Page #{idx + 1}"
        products = paginated_products.page(idx + 1)

        html = _page_html products, title
        file_path = idx == 0 ? "#{@output}/#{_strip_unsafe retailer}/index.html" : "#{@output}/#{_strip_unsafe retailer}/index-page-#{idx+1}.html"

        f = File.new file_path, "w"
        f << html
        f.close
      end

      end
    end

    def _strip_unsafe(str)
      str.gsub(/[^0-9a-z ]/i, '')
    end

    def _create_index
      paginated_products = Grocerly::Paginator.new _product_list.data, 20

      paginated_products.pages.times.with_index do |idx|

        title = idx == 0 ? "Index" : "Index - Page #{idx + 1}"
        products = paginated_products.page(idx + 1)

        html = _page_html products, title
        file_path = idx == 0 ? "#{@output}/index.html" : "#{@output}/index-page-#{idx+1}.html"

        f = File.new file_path, "w"
        f << html
        f.close

      end

    end

    def _create_dirs
      dirs = [@output]
      _retailers.each { |r| dirs << "#{@output}/#{_strip_unsafe r}/" }
      FileUtils.mkdir_p dirs
    end

    def _retailers
      _product_list.retailers
    end

    def _page_html(products, title)
      header = Grocerly::Html::Header.new title: title
      body = Grocerly::Html::Body.new products: products

      html = Grocerly::Html::Html.new header: header, navbar: _navbar, body: body
      html.call
    end

    def _navbar
      @navbar ||= Grocerly::Html::Navbar.new retailers: _product_list.retailers
    end

    def _product_list
      j = JsonParser.new _json
      @product_list ||= j.parse
    end

    def _json
      f = File.open @input, "r"
      json = f.read
      f.close
      json
    end

    def _parse_opts

      optparse = OptionParser.new do |opts|
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

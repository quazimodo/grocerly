require 'spec_helper'
require 'grocerly/main'

describe Grocerly::Main do

  let(:dir) {"/tmp/#{SecureRandom.hex(10)}/" }
  let(:json) { File.expand_path('../../../support/products.json', __FILE__) }
  let(:main) { Grocerly::Main.new }

  it "takes an input path" do
    args = ["-o", dir]
    expect{main.run(args)}.to raise_error
  end

  it "takes an output path" do
    args = ["-i", json]
    expect{main.run(args)}.to raise_error
  end

  it "creates the index html file" do
    args = ["-i", json, "-o", dir]
    main.run(args)

    html = File.read "#{dir}/index.html"

    expect(html).to include "Grocerly | Index"
  end

  it "creates the index page 3 html file" do
    args = ["-i", json, "-o", dir]
    main.run(args)

    html = File.read "#{dir}/index-page-3.html"

    expect(html).to include "Grocerly | Index - Page 3"
  end

  it "creates a retailer index html file" do
    args = ["-i", json, "-o", dir]
    main.run(args)

    html = File.read "#{dir}/La Manna Fresh/index.html"

    expect(html).to include "Grocerly | La Manna Fresh"
  end

  it "creates a retailer page 3 html file" do
    args = ["-i", json, "-o", dir]
    main.run(args)

    html = File.read "#{dir}/La Manna Fresh/index-page-3.html"

    expect(html).to include "Grocerly | La Manna Fresh - Page 3"
  end

  it "creates html files with pagination" do
    args = ["-i", json, "-o", dir]
    main.run(args)

    html = File.read "#{dir}/index.html"

    expect(html).to include %_class="pagination"_
  end

end

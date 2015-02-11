require 'spec_helper'
require 'cgi/html'
require 'grocerly/html/base'

describe Grocerly::Html::Base do

  let(:base) { Grocerly::Html::Base.new }

  describe "#initialize" do
    it "escapes unsafe data" do
      expect_any_instance_of(Grocerly::Html::Base).to receive(:escape_enum).with({foo: "bar"})

    Grocerly::Html::Base.new({foo: "bar"})

    end
  end

  describe "#cgi" do

    it "returns a CGI html5 object" do
      expect(base.cgi).to be_a_kind_of CGI::HTML5
    end
  end

  describe "#escape_enum" do

    let(:hash) do
      { "foo" => ["<script>dangerous javascript</script>", "other"],
       "bar" => "<script></script>",
       "baz" => {zed: "<script></script>",
                 swank: ["<script></script>",
                         "hi",
                         {outa_words: "<script></script>"}]}}
    end

    let(:escaped) {base.escape_enum hash}

    it "html escapes strings" do
      expect(escaped["bar"]).to eq "&lt;script&gt;&lt;/script&gt;"
    end

    it "html escapes nested arrays" do
      expect(escaped["foo"][0]).to eq "&lt;script&gt;dangerous javascript&lt;/script&gt;"
    end

    it "html escapes nested hashes" do
      expect(escaped["baz"][:zed]).to eq "&lt;script&gt;&lt;/script&gt;"
    end

    it "html escapes deeper nested arrays" do
      expect(escaped["baz"][:swank][0]).to eq "&lt;script&gt;&lt;/script&gt;"
    end

   it "html escapes deeper nested hashes" do
      expect(escaped["baz"][:swank][2][:outa_words]).to eq "&lt;script&gt;&lt;/script&gt;"
    end

  end

  describe "#call" do

    it "calls _generate with the optional opts" do
      expect(base).to receive :_generate
      base.call
    end

    it "raises an error if _generate isn't redefined in a subclass" do

      class TestClass < Grocerly::Html::Base
      end
      test_obj = TestClass.new

      expect{ test_obj.call }.to raise_error NotImplementedError
    end

  end

end


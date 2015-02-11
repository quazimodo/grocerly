require 'spec_helper'
require 'cgi/html'
require 'grocerly/html/base'

describe Grocerly::Html::Base do

  let(:base) { Grocerly::Html::Base.new }

  describe "#cgi" do

    it "returns a CGI html5 object" do
      expect(base.cgi).to be_a_kind_of CGI::HTML5
    end
  end

  describe "#escape_hash" do

    it "html escapes all the values of each key" do

      hash = { "foo" => "<script>dangerous javascript</script>",
              "foo2" => "<bar2></bar>" }
      escaped = base.escape_hash hash

      escaped.each do |k, v|

        expect(v).to_not include "<"
        expect(v).to_not include ">"

      end

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


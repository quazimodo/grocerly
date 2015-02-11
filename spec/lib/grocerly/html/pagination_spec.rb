require 'spec_helper'
require 'grocerly/html/pagination'


describe Grocerly::Html::Pagination do

  let(:pagination) { Grocerly::Html::Pagination.new page: 3, pages: 5, base_path: "/YourGrocer" }
  let(:html) { pagination.call }

  describe "#call" do

    it "generats a 'first' link" do
      expect(html).to include %-<A href="/YourGrocer/index.html"-
    end

    it "generates the previous page link" do
      expect(html).to include %_<A href="/YourGrocer/index-page-2.html">2</A>_
    end

    it "doesn't generate the previous page link if it's currently page 1" do
      p = Grocerly::Html::Pagination.new page: 1, pages: 4, base_path: "/YourGrocer"
      html = p.call

      expect(html).to_not include %_<A href="/YourGrocer/index-page-0.html">0</A>_
    end

    it "generates the 2nd previous page link" do
      expect(html).to_not include %_<A href="/YourGrocer/index-page-1.html">1</A>_
      expect(html).to include %_<A href="/YourGrocer/index.html">1</A>_
    end

    it "doesn't generate the 2nd previous page link if it's currently page 2" do
      p = Grocerly::Html::Pagination.new page: 2, pages: 4, base_path: "/YourGrocer"
      html = p.call

      expect(html).to_not include %_<A href="/YourGrocer/index-page-0.html">0</A>_
    end

    it "generates a current page link" do
      expect(html).to include %_<LI class="active"><A href="#">3</A></LI>_
    end

    it "generates the next page link" do
      expect(html).to include %_<A href="/YourGrocer/index-page-4.html">4</A>_
    end

    it "doesn't generate the next page link if it's currently last page" do
      p = Grocerly::Html::Pagination.new page: 4, pages: 4, base_path: "/YourGrocer"
      html = p.call

      expect(html).to_not include %_<A href="/YourGrocer/index-page-5.html">5</A>_
    end

    it "generates the 2nd next page link" do
      expect(html).to include %_<A href="/YourGrocer/index-page-5.html">5</A>_
    end

    it "doesn't generate the 2nd next page link if it's currently 2nd last page" do
      p = Grocerly::Html::Pagination.new page: 3, pages: 4, base_path: "/YourGrocer"
      html = p.call

      expect(html).to_not include %_<A href="/YourGrocer/index-page-5.html">5</A>_
    end


    it "generates a 'last' link" do
      expect(html).to include %_<A href="/YourGrocer/index-page-4.html_
    end

    it "doesn't generates a 'last' link to page 1" do
      p = Grocerly::Html::Pagination.new page: 1, pages: 1, base_path: "/YourGrocer"
      html = p.call

      expect(html).to_not include %_<A href="/YourGrocer/index-page-1.html_
      expect(html).to include %_<A href="/YourGrocer/index.html"><SPAN>&raquo;</SPAN></A>_
    end

  end


end

require 'rails_helper'

RSpec.describe Crawler::Parser do
  before :each do
    @instance = SomeCrawler.new
  end

  describe '#parse' do
    it "scrape data from a website's category" do
      expect(@instance.copy_items).to be_a(Array)
    end

    it "scrape data from a website's category, from all category's pages" do
      expect(@instance.copy_items_with_paginator).to be_a(Array)
    end

    it "scrape data from a website's category, from all category's pages" do
      expect(@instance.copy_items_with_paginator).not_to be_empty
    end
  end
end

class SomeCrawler < Crawler::Parser
  URL = 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/garantijas_pagarinasana_portativajiem_datoriem'.freeze

  def copy_items
    parse URL, '.product a:not(.button)'
  end

  def copy_items_with_paginator
    parse URL, '.product a:not(.button)', '.paging-box a'
  end

  private

  def extract_data(_page)
    {}
  end
end

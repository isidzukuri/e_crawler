require "rails_helper"

RSpec.describe Crawler::Parser do
  before :each do
    # url = 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/garantijas_pagarinasana_portativajiem_datoriem'
    @instance = SomeCrawler.new
  end

  describe '#parse' do
    it "scrape data from a website's category" do
      expect(@instance.copy_items).to be_a(Array)
    end
  end

end

class SomeCrawler < Crawler::Parser
  # def parse_one
  #   url = 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/portativiedatori/asus_rog_gx700vo_90nb09f1m00560'
  #   process(url, browser)
  # end

  def copy_items
    url = 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/garantijas_pagarinasana_portativajiem_datoriem'
    parse url, '.product a:not(.button)'#, '.paging-box a'
  end

  private

  def extract_data(page)
    {}
  end
end


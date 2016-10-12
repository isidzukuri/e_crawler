require "rails_helper"

RSpec.describe Crawler::Sitemap do
  before :each do
    url = 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/garantijas_pagarinasana_portativajiem_datoriem'
    @instance = Crawler::Sitemap.new(url, '.product a:not(.button)', '.paging-box a')
  end

  describe '#items_urls' do
    it 'serchs links in dom of given page by selector' do
      expect(@instance.items_urls).to be_a(Array)
    end
  end

end


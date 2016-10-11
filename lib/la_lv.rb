class LaLv < Crawler::Parser
  
   # '.product a:not(.button)'
    # '.paging-box a'
  def copy_items
    parse 'http://www.1a.lv/datortehnika_preces_birojam/portativie_datori_un_aksesuari/portativiedatori/2', '.product a:not(.button)', '.paging-box a'
    # ap @data
    ap @data.count
    true
  end

  private

  def extract_data(page)
    title = page.search('.product-title-container h2').text
    description = page.search('.characteristics-table').to_s

    price = page.search('.new-price').text
    price = page.search('.price-box .price').text if price == ""

    {
      :title => page.search('.product-title-container h2').text,
      :description => page.search('.characteristics-table').to_s,
      :price => price.to_i,
      :source => page.uri.to_s,
      :images => images(page).to_json
    }
  end

  def images page
    result = []
    page.search('.image-thumbnails-slider img').each do |tag|
      path = tag.attribute('src')
      if path
        path.to_s.gsub!('_xs', '_xl')
        result << "#{page.uri.scheme}://#{page.uri.host}#{path}"
      end
    end
    result
  end

end


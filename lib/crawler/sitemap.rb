module Crawler
  class Sitemap
    def initialize(url, item_attr, paginator_attr = nil, use_cache = true)
      @base_url = url
      @item_attr = item_attr
      @paginator_attr = paginator_attr
      @use_cache = use_cache
      @browser = Browser.new use_cache
    end

    def items_urls
      extract_host
      find_links
    end

    private

    attr_accessor :browser
    attr_reader :scheme, :host, :paginator_attr, :item_attr, :base_url

    def extract_host
      uri = URI.parse(base_url)
      @scheme = uri.scheme
      @host = uri.host.downcase
    end

    def find_links
      items_urls = Set.new
      items_pages = paginator_links
      items_pages.each do |page_url|
        items_urls += items_on_page(page_url)
      end
      items_urls.to_a
    end

    def paginator_links
      if paginator_attr
        pages_from_paginator(base_url)
      else
        [base_url]
      end
    end

    def items_on_page(url)
      page = browser.load_page(url)
      links_by_attr(page, item_attr)
    end

    def links_by_attr(page, attribute)
      page.search(attribute).map do |element|
        href = element.attribute('href').to_s
        href.include?(host) ? href : "#{scheme}://#{host}#{href}"
      end
    end

    def pages_from_paginator(url)
      page = browser.load_page(url)
      current_page_links = links_by_attr(page, paginator_attr)
      pages << url
      current_page_links.each do |link|
        next if pages.include?(link)
        pages_from_paginator(link)
      end
      @items_pages
    end

    def pages
      @items_pages ||= Set.new
    end
  end
end

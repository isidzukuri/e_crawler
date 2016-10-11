module Crawler
  class Browser
    def initialize(use_cache = true)
      @agent = Mechanize.new
      @use_cache = use_cache
    end

    def load_page(url)
      if @use_cache
        page_from_cache(url) || cache_page(url)
      else
        @agent.get(url)
      end
    end

    private

    def page_from_cache(url)
      content = nil
      if page = CACHE.read(url)
        content = Mechanize::Page.new(URI(url), { 'content-type' => 'text/html' }, page, nil, @agent)
      end
      content
    end

    def cache_page(url)
      page = @agent.get(url)
      CACHE.write(url, page.body)
      page
    end
  end
end

module Crawler
	class Parser


# '.product a:not(.button)'
# '.paging-box a'


		def initialize settings = {}
			@settings = {
				:threads_number => 1, 
				:use_cache => true
			}
			@settings.merge!(settings)
			@data = []
		end

		def parse url, item_attr, paginator_attr = nil
			sitemap = Sitemap.new(url, item_attr, paginator_attr, @settings)
			urls_list = sitemap.items_urls
			ap urls_list
			@queue = Crawler::Queue.new(urls_list)
			threads = []
			@settings[:threads_number].times do 
				threads << Thread.new do
					browser = Browser.new @settings[:use_cache]
					next_url = @queue.next
					while next_url do
						# begin
				   		parse_one(next_url, browser)
				   	# rescue
				   	# end
				   	next_url = @queue.next
				   	# ap @queue.items_left
				   	ap next_url
					end
				end
			end
			threads.each { |thr| thr.join }
			@data
		end
		

		def parse_one url, browser
			page = browser.load_page(url)
			data = extract_data(page)
			@data << data if data
		end

		def extract_data page
			# raise NoMethodError.new("Implement :extract_data method") 
			raise Crawler::Exception.new("Implement :extract_data method") 
		end

		
	end
end

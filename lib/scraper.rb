require "open-uri"
require "nokogiri"

class Scraper
  self.scrape_from_youtube(link)
    html = Nokogiri::HTML(open("https://www.youtube.com/watch?v=rLCwc_nrimk&list=PLP4CSgl7K7or84AAhr7zlLNpghEnKWu2c&index=1"))
    p html.css("#description").text
  end
end
    
Scraper.scrape_from_youtube("https://www.youtube.com/watch?v=rLCwc_nrimk&list=PLP4CSgl7K7or84AAhr7zlLNpghEnKWu2c&index=1")
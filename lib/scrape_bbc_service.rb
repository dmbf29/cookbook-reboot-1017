require 'open-uri'
require 'json'
require 'nokogiri'

class ScrapeBbcService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # file = '/Users/dougberks/code/lewagon/lectures/1017/cookbook-reboot/lib/cheese.html'
    # html = File.open(file)
    html = URI.open("https://www.bbcgoodfood.com/search\?q\=#{@keyword}", "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
    doc = Nokogiri::HTML(html)
    info_hash = JSON.parse(doc.search('.js-search-data').text)["results"]

    # TODO: return a list of `Recipe` built from scraping the web.
    doc.search('.standard-card-new').first(5).map do |card|
      name = card.search('.standard-card-new__article-title').text.strip
      recipe_hash = info_hash.find do |recipe_hash|
        recipe_hash['title'] == name
      end
      description = recipe_hash['description']
      rating = recipe_hash['userRatings']['starRatingAverage']
      prep_time = recipe_hash['totalTimeArray']['totalTimeHumanReadable']
      Recipe.new(
        name: name,
        description: description,
        rating: rating,
        prep_time: prep_time
      )
    end
  end
end

# We will call this method in our controller 👇
# ScrapeBbcService.new('strawberry').call

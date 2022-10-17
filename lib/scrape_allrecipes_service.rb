require 'open-uri'
require 'json'
require 'nokogiri'

class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    file = '/Users/dougberks/code/lewagon/lectures/1017/cookbook-reboot/lib/cheese.html'
    html = File.open(file)
    doc = Nokogiri::HTML(html)
    info_hash = JSON.parse(doc.search('.js-search-data').text)["results"]

    # TODO: return a list of `Recipe` built from scraping the web.
    doc.search('.standard-card-new').first(5).map do |card|
      p name = card.search('.standard-card-new__article-title').text.strip
      recipe_hash = info_hash.find do |recipe_hash|
        recipe_hash['title'] == name
      end
      # description = get the description from the recipe_hash
      # Recipe.new(name, description)
    end
  end
end

# We will call this method in our controller 👇
# ScrapeAllrecipesService.new('strawberry').call

    # doc.search('html_tag')
    # p doc.search('h1')

    # p doc.search('.class')
    # p doc.search('.card__img')

    # doc.search('#id')
    # doc.search('#banner')

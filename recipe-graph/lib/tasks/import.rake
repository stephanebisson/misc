require 'nokogiri'
require 'open-uri'
require 'anemone'

BASE_URL = 'http://allrecipes.com/'

namespace :import do
  desc "imports recipes from allrecipes.com"
  task allrecipes: :environment do
  	Anemone.crawl(BASE_URL) do |anemone|
  	  anemone.on_pages_like /allrecipes\.com\/recipe\/.*?\/detail\.aspx/ do |page|
  	  	puts page.url.to_s
  	  	save_page(page.url)
  	  	# if recipe_page(page.url.to_s)
  	  	# 	doc = Nokogiri::HTML(open(page.url))
  	  	# 	extract_recipe doc, page.url
  	  	# else
  	  	# 	print '.'
  	  	# end
  	  end
  	end

  end
end

def friendly_filename(filename)
    filename.gsub(BASE_URL, '')
    				.gsub(/$recipe/, '')
    				.gsub(/(\.aspx.*)/, '')
    				.gsub(/[^\w\s_-]+/, '')
            .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
            .gsub(/\s+/, '_')
end

def save_page(url)
	open("./pages/#{friendly_filename(url.to_s)}", 'wb') do |file|
	  file << open(url).read
	end
end

def recipe_page(url)
	url.start_with? "#{BASE_URL}recipe/"
end

def extract_recipe(doc, url)
	return unless doc.css('#zoneRecipe').present?

	name = doc.css('#itemTitle').text

	return if Recipe.where(name: name, url: url.to_s).exists?

	recipe = Recipe.create(name: name, url: url.to_s)

	doc.css('p.fl-ing').each do |i|
		ingr_name = i.css('.ingredient-name').text
		ingr_amount = i.css('.ingredient-amount').text

		ingredient = Ingredient.find_or_create_by(name: ingr_name.downcase)
		recipe.recipe_ingredients.create ingredient: ingredient, quantity: ingr_amount
	end
	recipe.save!
	puts name
end
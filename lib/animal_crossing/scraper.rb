require "open-uri"
require "nokogiri"
require "pry"

class AnimalCrossing::Scraper
    html = open("https://animalcrossing.fandom.com/wiki/Villager_list_(New_Horizons)")
    doc = Nokogiri::HTML(html)
    attr_arr = []
    final_attr_arr = []
    villagers = []
    keys = [:name, :gender, :personality, :species, :birthday, :catch_phrase, :hobbies, :image_url]
    image_urls = doc.css("table.roundy.sortable td a").map{|i| i["href"].start_with?("https") ? i["href"] : nil}.reject{|i| i == nil}
    attributes = doc.css("table.roundy.sortable td").map{|i| i.text.strip}.reject{|i| i == ""}
    attributes.each_slice(6){|i| attr_arr << i}
    attr_arr.map{|i| i.map{|i| i.start_with?("♂", "♀") ? i.split(" ") : i}}.flatten.each_slice(7){|i| final_attr_arr << i}
    image_urls.each_with_index{|v, i| final_attr_arr[i] << v}
    final_attr_arr.each{|i| villagers << i.each_with_object({}){|str, hsh| hsh[keys[i.index(str)]] = str}}
    binding.pry
    # find out how to get images to load in terminal
    # find out how to load individual villager images and a title page image
end
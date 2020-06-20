class AnimalCrossing::Villager
    attr_accessor :name, :gender, :personality, :species, :birthday, :catch_phrase, :hobbies, :image_url

    @@all = []

    def initialize(name: nil, gender: nil, personality: nil, species: nil, birthday: nil, catch_phrase: nil, hobbies: nil, image_url: nil)
        @name = name
        @gender = gender
        @personality = personality
        @species = species
        @birthday = birthday
        @catch_phrase = catch_phrase
        @hobbies = hobbies
        @image_url = image_url
        AnimalCrossing::Villager.all << self
    end

    def self.all
        @@all
    end

    def self.mass_assign_from_scraper
        villagers = AnimalCrossing::Scraper.scrape_wiki
        villagers.each{|i| self.new(i)}
    end

    def self.names
        self.all.map{|i| i.name.downcase}
    end

    def self.sort_by_name
        self.all.sort{|a, b| a.name <=> b.name }.each_with_index{|v, i| puts "#{i+1}. #{v.name}"}
    end

    def self.species
        self.all.map{|i| i.species}.uniq.sort{|a, b| a <=> b}.each_with_index{|v, i| puts "#{i+1}. #{v}"}
    end

    def self.list_by_species(species_name)
        self.all.select{|i| i.species == species_name}.sort{|a, b| a.name <=> b.name}.each_with_index{|v, i| puts "#{i+1}. #{v.name}"}
    end

    def self.list_by_hobbies(hobbies_name)
        self.all.select{|i| i.hobbies == hobbies_name}.sort{|a, b| a.name <=> b.name}.each_with_index{|v, i| puts "#{i+1}. #{v.name}"}
    end

    def self.view_villager_wiki(villager_name)
        villager = AnimalCrossing::Villager.all.detect{|i| i.name.downcase == villager_name.downcase} if self.names.include?(villager_name.downcase)
        villager_name = villager.name
        if villager_name.include?(" ")
            villager.name.gsub(/\s/, "_")
        elsif villager_name.include?("'")
            villager.name.gsub(/\W/, "%27")
        end
        Launchy.open(AnimalCrossing::Scraper.base_url + villager_name) if villager != nil
    end

    def self.villager_info(villager_name)
        villager = self.all.select{|i| i.name.downcase == villager_name.downcase}.first
        puts "Name: #{villager.name.colorize(:light_yellow)}\nGender: #{villager.gender.colorize(:light_yellow)}\nPersonality: #{villager.personality.colorize(:light_yellow)}\nSpecies: #{villager.species.colorize(:light_yellow)}\nBirthday: #{villager.birthday.colorize(:light_yellow)}\nCatchphrase: #{villager.catch_phrase.colorize(:light_yellow)}\nHobby: #{villager.hobbies.colorize(:light_yellow)}"
    end

    def self.personalities
        self.all.map{|i| i.personality}.uniq.reject{|i| i == nil}.sort{|a, b| a <=> b}.each_with_index{|v, i| puts "#{i+1}. #{v}"}
    end

    def self.list_by_personalities(personality_name)
        self.all.select{|i| i.personality == personality_name}.sort{|a, b| a.name <=> b.name}.each_with_index{|v, i| puts "#{i+1}. #{v.name}"}
    end

    def self.hobbies
        self.all.map{|i| i.hobbies}.uniq.sort{|a, b| a <=> b}.each_with_index{|v, i| puts "#{i+1}. #{v}"}
    end

    def self.sort_by_birthday
    end

    # create methods to sort by name, personality, species, sort_by_birthday
    # bonus methods: sort_by_catchphrase, sort_by_hobby
end
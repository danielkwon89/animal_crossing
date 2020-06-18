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

    # create methods to sort by name, personality, species, sort_by_birthday
    # bonus methods: sort_by_catchphrase, sort_by_hobby
end
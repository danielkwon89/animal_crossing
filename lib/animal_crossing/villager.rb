class AnimalCrossing::Villager
    attr_accessor :name, :gender, :personality, :species, :birthday, :catch_phrase, :hobbies, :image_url

    @@all = []

    def initialize(name:, gender:, personality:, species:, birthday:, catch_phrase:, hobbies:, image_url:)
        @name = name
        @gender = gender
        @personality = personality
        @species = species
        @birthday = birthday
        @catch_phrase = catch_phrase
        @hobbies = hobbies
        Villager.all << self
    end

    def self.all
        @@all
    end

    def self.mass_assign_from_scraper
    end

    # create methods to sort by name, personality, species, sort_by_birthday
    # bonus methods: sort_by_catchphrase, sort_by_hobby
end
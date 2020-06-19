class AnimalCrossing::CLI
    def call
        scrape
        welcome
        menu
    end

    def welcome
        input = nil
        puts '
        _   _   _   _   _   _     _   _   _   _   _   _   _   _     _   _   _   _   _   _   _   _   _  
       / \ / \ / \ / \ / \ / \   / \ / \ / \ / \ / \ / \ / \ / \   / \ / \ / \ / \ / \ / \ / \ / \ / \ 
      ( A | n | i | m | a | l ) ( C | r | o | s | s | i | n | g ) ( V | i | l | l | a | g | e | r | s )
       \_/ \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ 
     '.colorize(:light_yellow)
     
        until input == "list"

            puts <<~HEREDOC
            \nWelcome to the Animal Crossing Villagers CLI gem!
            \nType #{"list".colorize(:light_cyan)} to list villagers or #{"species".colorize(:light_cyan)} to view species:
            HEREDOC

            input = gets.strip.downcase
            if input == "list"
                list_villagers
            elsif input == "species"
                list_species
            else
                puts "Invalid entry."
            end
        end
    end

    def scrape
        AnimalCrossing::Villager.mass_assign_from_scraper
    end

    def list_villagers
        puts '
        _   _   _   _   _   _   _   _   _  
       / \ / \ / \ / \ / \ / \ / \ / \ / \ 
      ( V | i | l | l | a | g | e | r | s )
       \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ 
     '.colorize(:light_yellow)

        AnimalCrossing::Villager.sort_by_name
    end

    def list_species
        input = nil
        puts '
        _   _   _   _   _   _   _  
       / \ / \ / \ / \ / \ / \ / \ 
      ( S | p | e | c | i | e | s )
       \_/ \_/ \_/ \_/ \_/ \_/ \_/ 
     '.colorize(:light_yellow)

        species

        puts "\n"
        puts "Type a #{'species name'.colorize(:light_cyan)} to view villagers of that #{'species'.colorize(:light_cyan)} (e.g. #{'"Hippo"'.colorize(:light_cyan)})."
        input = gets.strip.capitalize
        
        if species.include?(input)
            puts "\n"

            puts "#{input} Villagers"
            puts "\n"
            list_by_species(input)
            puts "\n"
            puts "Enter the #{"name".colorize(:light_cyan)} of the villager to get more info on (e.g. #{'"Bubbles"'.colorize(:light_cyan)})."

            name = gets.strip
            # binding.pry
            until AnimalCrossing::Villager.all.select{|i| i.species == input}.map{|i| i.name.downcase}.include?(name.downcase)
            # binding.pry
            puts "Invalid entry. Enter the #{"name".colorize(:light_cyan)} of the villager to get more info on (e.g. #{'"Kyle"'.colorize(:light_cyan)})."
            name = gets.strip
            end
            # binding.pry
            name = AnimalCrossing::Villager.all.select{|i| i.name.downcase == name.downcase}.first.name
            view_villager_wiki(name)
        else
            puts "Invalid entry."
        end
    end

    def menu
        input = nil

        while input != "exit"
            puts "\nEnter the #{"name".colorize(:light_cyan)} of the villager to get more info on (e.g. #{'"Zucker"'.colorize(:light_cyan)}). Enter #{"list".colorize(:light_cyan)} to list villagers, #{"species".colorize(:light_cyan)} to list species or #{"exit".colorize(:light_cyan)} to exit:"

            input = gets.strip

            if names.include?(input.capitalize)
                view_villager_wiki(input.capitalize)
            else
                case input.downcase
                when "list"
                    list_villagers
                when "species"
                    list_species
                when "exit"
                    goodbye
                else
                    puts "Invalid entry."
                end
            end
        end
    end

    def goodbye
        puts "\nThank you for using the Animal Crossing Villagers CLI gem!"
        puts '
        _   _   _   _   _     _   _   _   _  
       / \ / \ / \ / \ / \   / \ / \ / \ / \ 
      ( T | h | a | n | k ) ( y | o | u | ! )
       \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ 
     '.colorize(:light_yellow)

        puts "\n"
    end

    def view_villager_wiki(villager_name)
        AnimalCrossing::Villager.view_villager_wiki(villager_name)
    end

    def names
        AnimalCrossing::Villager.names
    end

    def species
        AnimalCrossing::Villager.species
    end

    def list_by_species(species_name)
        AnimalCrossing::Villager.list_by_species(species_name)
    end

    def villager_info
    end
end # AnimalCrossing::CLI
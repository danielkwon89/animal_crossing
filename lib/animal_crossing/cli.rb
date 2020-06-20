class AnimalCrossing::CLI
    def call
        scrape
        # binding.pry
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
            \nType #{"list".colorize(:light_cyan)} to list villagers, #{"species".colorize(:light_cyan)} to view species or #{"personalities".colorize(:light_cyan)} to view personalities:
            HEREDOC

            input = gets.strip.downcase
            if input == "list"
                list_villagers
            elsif input == "species"
                list_species
            elsif input == "personalities"
                list_personalities
            else
                puts "Invalid entry."
            end
        end
    end

    def scrape
        AnimalCrossing::Villager.mass_assign_from_scraper
    end

    def list_personalities
        puts '
        _   _   _   _   _   _   _   _   _   _   _   _   _  
       / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ 
      ( P | e | r | s | o | n | a | l | i | t | i | e | s )
       \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ 
     '.colorize(:light_yellow)

        personalities

        puts "\n"
        puts "Type a #{'personality name'.colorize(:light_cyan)} to view villagers of that #{'personality'.colorize(:light_cyan)} (e.g. #{'"Smug"'.colorize(:light_cyan)})."
        input = gets.strip.capitalize
        
        if personalities.include?(input)
            puts "\n"

            puts "#{input} Villagers"
            puts "\n"
            list_by_personalities(input)
            puts "\n"
            puts "Enter the #{"name".colorize(:light_cyan)} of the villager to get more info on (e.g. #{'"Bubbles"'.colorize(:light_cyan)})."

            name = gets.strip
            until AnimalCrossing::Villager.all.select{|i| i.personality == input}.map{|i| i.name.downcase}.include?(name.downcase)
            puts "Invalid entry. Enter the #{"name".colorize(:light_cyan)} of the villager to get more info on (e.g. #{'"Peppy"'.colorize(:light_cyan)})."
            name = gets.strip
            end
            name = AnimalCrossing::Villager.all.select{|i| i.name.downcase == name.downcase}.first.name
            puts "\n"
            villager_info(name)
        else
            puts "Invalid entry."
        end

        puts "\n"
        puts "Enter #{"wiki".colorize(:light_cyan)} to view the villager's wiki or #{"menu".colorize(:light_cyan)} for the menu."
        input = gets.strip
        if input == "wiki"
            view_villager_wiki(name)
        end
    end

    def list_villagers
        puts '
        _   _   _   _   _   _   _   _   _  
       / \ / \ / \ / \ / \ / \ / \ / \ / \ 
      ( V | i | l | l | a | g | e | r | s )
       \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ 
     '.colorize(:light_yellow)

        sort_by_name
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

            puts "#{input} Villagers".colorize(:light_yellow)
            puts "\n"
            list_by_species(input)
            puts "\n"
            puts "Enter the #{"name".colorize(:light_cyan)} of the villager to get more info on (e.g. #{'"Bubbles"'.colorize(:light_cyan)})."

            name = gets.strip
            until AnimalCrossing::Villager.all.select{|i| i.species == input}.map{|i| i.name.downcase}.include?(name.downcase)
            puts "Invalid entry. Enter the #{"name".colorize(:light_cyan)} of the villager to get more info on (e.g. #{'"Kyle"'.colorize(:light_cyan)})."
            name = gets.strip
            end
            name = AnimalCrossing::Villager.all.select{|i| i.name.downcase == name.downcase}.first.name

            puts "\n"
            villager_info(name)
            
            puts "\n"
            puts "Enter #{"wiki".colorize(:light_cyan)} to view the villager's wiki or #{"menu".colorize(:light_cyan)} for the menu."
            input = gets.strip
            if input == "wiki"
                view_villager_wiki(name)
            end
        else
            puts "Invalid entry."
        end
    end

    def menu
        name = nil

        while name != "exit"
            puts "\nEnter the #{"name".colorize(:light_cyan)} of the villager to get more info on (e.g. #{'"Zucker"'.colorize(:light_cyan)}). Enter #{"list".colorize(:light_cyan)} to list villagers, #{"species".colorize(:light_cyan)} to list species, #{"personalities".colorize(:light_cyan)} to list personalities or #{"exit".colorize(:light_cyan)} to exit:"

            name = gets.strip

            if names.include?(name.downcase)
                puts "\n"
                villager_info(name.downcase)

                puts "\n"
                puts "Enter #{"wiki".colorize(:light_cyan)} to view the villager's wiki or #{"menu".colorize(:light_cyan)} for the menu."
                input = gets.strip
                if input == "wiki"
                    view_villager_wiki(name)
                end
            else
                case name.downcase
                when "list"
                    list_villagers
                when "species"
                    list_species
                when "personalities"
                    list_personalities
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
        name = AnimalCrossing::Villager.all.select{|i| i.name.downcase == villager_name.downcase}.first.name
        AnimalCrossing::Villager.view_villager_wiki(name)
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

    def villager_info(villager_name)
        AnimalCrossing::Villager.villager_info(villager_name)
    end

    def personalities
        puts "\n"
        AnimalCrossing::Villager.personalities
    end

    def sort_by_name
        AnimalCrossing::Villager.sort_by_name
    end

    def list_by_personalities(personality_name)
        AnimalCrossing::Villager.list_by_personalities(personality_name)
    end

end # AnimalCrossing::CLI
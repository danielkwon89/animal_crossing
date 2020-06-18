class AnimalCrossing::CLI
    def call
        welcome
        menu
    end
    
    def list_villagers
        puts '
        _   _   _   _   _   _   _   _   _  
       / \ / \ / \ / \ / \ / \ / \ / \ / \ 
      ( V | i | l | l | a | g | e | r | s )
       \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ 
     '.colorize(:light_yellow)
        AnimalCrossing::Villager.mass_assign_from_scraper
        AnimalCrossing::Villager.all.each_with_index{|v, i| puts "#{i+1}. #{v.name}"}
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
            \nType 'list' to list villagers:
            HEREDOC

            input = gets.strip.downcase

            if input == "list"
                list_villagers
            else
                puts "Invalid entry."
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

    def menu
        input = nil
        while input != "exit"
            puts "\nEnter the number of the villager you'd like more information on. Enter 'list' to list villagers or 'exit' to exit:"
            input = gets.strip
            case input.strip.downcase
            when "exit"
                goodbye
            when "1"
                puts "Here's more info on Annie."
            when "2"
                puts "Here's more info on Brian."
            when "3"
                puts "Here's more info on Carl."
            when "list"
                list_villagers
            else
                puts "Invalid entry."
            end
        end
    end
end # AnimalCrossing::CLI
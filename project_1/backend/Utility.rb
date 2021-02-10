require './backend/Card'
require './backend/Deck'
require './backend/Player'
#require 'rsvg2'

=begin
  Utility module provides helpful functions that are used many times across the game.
=end
module Utility
    CARD_LENGTH = 174
    CARD_WIDTH = 120

########################
###### Game Logic ######
########################

    #Checks if 3 cards form a set
    #This function checks for 4 conditions to determine if cards form a set:
    #They all have the same number or have three different numbers.
    #They all have the same shape or have three different shapes.
    #They all have the same shading or have three different shadings.
    #They all have the same color or have three different colors.
    def checkSet(card1, card2, card3)
        if card1 and card2 and card3 #saftey check that no card is nil
            shapeCondition = ((card1.shape == card2.shape and card2.shape == card3.shape) or (card1.shape != card2.shape and card1.shape != card3.shape and card2.shape != card3.shape))
            shadeCondition = ((card1.shade == card2.shade and card2.shade == card3.shade) or (card1.shade != card2.shade and card1.shade != card3.shade and card2.shade != card3.shade))
            numberCondition = ((card1.number == card2.number and card2.number == card3.number) or (card1.number != card2.number and card1.number != card3.number and card2.number != card3.number))
            colorCondition = ((card1.color == card2.color and card2.color == card3.color) or (card1.color != card2.color and card1.color != card3.color and card2.color != card3.color))

            if shapeCondition and shadeCondition and numberCondition and colorCondition
                return true
            else
                return false  
            end
        else
            return false
        end
    end

    #Finds number of sets in a given array of cards
    #Game of et is NP-complete, so check for all possible sets
    def countSets(cards)
        count = 0
        for i in 0..cards.length-1
            for j in i+1..cards.length-1
                for k in j+1..cards.length-1
                    if checkSet(cards[i],cards[j],cards[k])
                        count +=1
                    end
                end
            end
        end
        return count
    end

    #Given array of cards, returns the index of a card that's included on some set
    def hint(cards)
        for i in 0..cards.length-1
            for j in i+1..cards.length-1
                for k in j+1..cards.length-1
                    if checkSet(cards[i],cards[j],cards[k])
                        return i
                    end
                end
            end
        end
        return false
    end

    #Given array of cards, returns one valid set (or nil)
    def idSet(cards)
        for i in 0..cards.length-1
            for j in i+1..cards.length-1
                for k in j+1..cards.length-1
                    if checkSet(cards[i],cards[j],cards[k])
                        return [i,j,k]
                    end
                end
            end
        end
        return nil
    end

    #Returns string of overall game time in minutes and seconds
    def gameTime(start)
        seconds = Time.now - start
        minutes = seconds / 60
        seconds %= 60
        return minutes.to_i.to_s+":"+seconds.to_i.to_s
    end

=begin
    #This function is used only once to generate all the png cards from the svg file
    def generateCardImages()
        deck = Deck.new
        while deck.remain? > 0
            card = deck.draw
            file = File.open("set_card.svg")
            data = file.read
            File.open("temp.svg", "w") { |f| f.write (data+"<g transform=\"translate(60,87) scale(3)\"><use xlink:href=\"#card\" class=\"noc\" /><use xlink:href=\"#o_#{card.xlink}\" class=\"#{card.class}\" /></g></svg>") }
            src = 'temp.svg'
            dst = card.image
            svg = RSVG::Handle.new_from_file(src)
            surface = Cairo::ImageSurface.new(Cairo::FORMAT_ARGB32, 120, 174)
            context = Cairo::Context.new(surface)
            context.render_rsvg_handle(svg)
            surface.write_to_png(dst)
        end
    end
=end

########################
#### Representation ####
########################

    #Calculate the position of a card image base on its index
    def position(i)
        x = 100
        y = 100
        x += i.modulo(4)* (CARD_WIDTH + 10)
        y += i/4*(CARD_LENGTH + 10)
        return x,y
    end


    #Determines if a mouse click lands on a button/card (for main game)
    def identifyClick(mouse_x,mouse_y)
        cardSelected = cardSelected(mouse_x,mouse_y) 
        buttonSelected = buttonSelected(mouse_x,mouse_y)
        if cardSelected(mouse_x,mouse_y) != nil
            return cardSelected
        else buttonSelected != nil
            return buttonSelected
        end
    end

    #Determines if a mouse click lands on a card
    def cardSelected(mouse_x,mouse_y)
        positions = []
        for i in 0..11
            position = position(i)
            if position[0] < mouse_x and position[0]+CARD_WIDTH > mouse_x and position[1] < mouse_y and position[1]+CARD_LENGTH > mouse_y
                return i
            end
        end
        return nil
    end

    #Determines if a mouse click lands on a button
    def buttonSelected(mouse_x,mouse_y)
        if 680 < mouse_x and 680+144 > mouse_x and 300 < mouse_y and 300+66 > mouse_y
            return "hint"
        elsif 663 < mouse_x and 663+180 > mouse_x and 380 < mouse_y and 380+66 > mouse_y
            return "shuffle"
        elsif 650 < mouse_x and 650+198 > mouse_x and 100 < mouse_y and 100+66 > mouse_y
            return "player1"
        elsif 650 < mouse_x and 650+202 > mouse_x and 200 < mouse_y and 200+66 > mouse_y
            return "player2"
        else
            return nil
        end
    end


    #Determines if a mouse click lands on a button (for welcome window)
    def gosOption(mouse_x,mouse_y)
        if 175 < mouse_x and 175+255 > mouse_x and 200 < mouse_y and 200+66 > mouse_y
            return "single"
        elsif 475 < mouse_x and 475+244 > mouse_x and 200 < mouse_y and 200+66 > mouse_y
            return "two"
        elsif 130 < mouse_x and 130+147 > mouse_x and 500 < mouse_y and 500+66 > mouse_y
            return "easy"
        elsif 330 < mouse_x and 330+259 > mouse_x and 500 < mouse_y and 500+66 > mouse_y
            return "inter"
        elsif 640 < mouse_x and 640+159 > mouse_x and 500 < mouse_y and 500+66 > mouse_y
            return "hard"
        end
    end



end
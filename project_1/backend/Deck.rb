require './backend/Card'

=begin
  Calss for deck objects.
=end

class Deck
    attr_reader :deck
    def initialize()
        @deck = [] #An array that will hold all card objects
        self.generate #Generate deck on initialization
    end

    #Removes a card from the deck and returns it
    def draw()
        return @deck.pop
    end

    #Puts a card object back in the deck
    def return(card)
        @deck.push(card)
    end

    #Returns number of card objects left in the deck
    def remain?
        return @deck.length
    end    

    #Shuffle cards in deck
    def shuffleDeck()
        @deck = @deck.shuffle
    end
    

    private

    #Generates all possible 81 cards in deck
    #Refer to Card class for properties naming convention
    def generate()
        shape = [ 'a', 'b', 'c' ]
        color = [ 'x', 'y', 'z' ]
        shade = [ 'i', 'j', 'k' ]
        value = [ '1', '2', '3' ]
        shape.each do |shape|
            color.each do |color|
                shade.each do |shade|
                    value.each do |value|
                        @deck << Card.new(shape, color, shade, value)                              
                    end
                end
            end
        end
        self.shuffleDeck #shuffle after generating
    end


end

require './backend/Utility'
include Utility

=begin
  Simple calss for game state.
=end

class GameState
    attr_accessor :option, :field, :score, :selectedPlayer, :deck, :set, :startTime, :fieldSets, :players, :currentPlayer, :deckSets, :turnTimer

    def initialize(option)
        @option = option        #determines game mode
        @score = []             #stores scores of players (ints)
        @deck = Deck.new        #deck of cards (one deck object)
        @field = []             #Card objects on field
        @set = []               #Card objects in set (selected cards)
        @startTime = Time.now   #Start time of the game
        @fieldSets              #Number of sets on field (int)
        @deckSets               #Number of sets in deck (int)
        @players = []           #Contains player objects
        @currentPlayer = nil    #Reference to player
        @turnTimer = nil        #Represents time at start of turn
    end

end
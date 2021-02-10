require './backend/Utility'
include Utility

=begin
    Generates in-game decision based on its state. When the AI is playing, its state is composed of:
    number of cards selected in a set (count), when’s the last time the AI played (aiTime),
    and what’s the difficulty of the AI (difficulty).

    Sensors: receives the cards on the playing field when it's the AI's turn.

    The AI increments in difficulty as follows:
    Easy: 21 seconds to find set (or shuffle)
    Intermediate: 14 seconds
    Hard: 7 seconds
=end
class AiAgent
    attr_accessor :count, :aiTime, :difficulty

    def initialize(difficulty)
        @count = 0
        @difficulty = 7 * difficulty
        @aiTime = Time.now
    end

    #Returns the id of next card to be selected in a set
    #If no set is found returns nil
    def nextCard(cards)
        solutions = idSet(cards)
        if solutions
            @count +=1
            return solutions[@count-1]
        else
            return nil
        end
    end

end
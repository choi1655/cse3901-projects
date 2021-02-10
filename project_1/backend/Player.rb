require './backend/Utility.rb'

=begin
  Simple calss for player objects.
=end

class Player
    attr_accessor :id, :score

    def initialize(id)
        @id = id
        @score = 0
    end
end
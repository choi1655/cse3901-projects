require 'gosu'

=begin
  This is the gameover window.
  Final stats are shown here
=end

class GameOver < Gosu::Window
    #Simillar functions are explaind in gui.rb
    def initialize (scores,time)
      super 400, 400
      self.caption = "Game of Set"
      @font = Gosu::Font.new(30)
      @scores = scores #scores for all players
      @time = time #overall time of the game
    end
    
    def update
      # ...
    end
    
    def draw
        @font.draw_text("Game Over", 130, 70, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
        @font.draw_text("Time: #{@time}", 140, 120, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
        @font.draw_text("Scores:", 140, 200, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
        @font.draw_text("Player#1 : #{@scores[0]}", 110, 240, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
        @font.draw_text("Player#2 : #{@scores[1]}", 110, 280, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    end



    def needs_cursor?
        true
    end

    def button_down(id)
        
    end
  end
require './gui.rb'

=begin
  This is the welcome page window.
  Player(s) may select game mode here.
=end
class WelcomePage < Gosu::Window
    #Simillar functions are explaind in gui.rb
    def initialize
      super 900, 750
      self.caption = "Game of Set"
      @font = Gosu::Font.new(30)
      @font2 = Gosu::Font.new(40)
      @font3 = Gosu::Font.new(20)
      @single= Gosu::Image.new("media/button_single.png")
      @two = Gosu::Image.new("media/button_two.png")
      @easy = Gosu::Image.new("media/button_easy.png")
      @inter = Gosu::Image.new("media/button_intermediate.png")
      @hard = Gosu::Image.new("media/button_hard.png")
      @playComputer = Gosu::Image.new("media/play_computer.png")
    end
    
    def update
      # ...
    end
    
    def draw
        @font.draw_text("Play Against Computer", 310, 420, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
        @font2.draw_text("Game of Set", 335, 50, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
        @font3.draw_text("CSE3901 SlackOverflow", 350, 680, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
        @single.draw(175,200,0)
        @two.draw(475,200,0)
        @easy.draw(130,500,0)
        @inter.draw(330,500,0)
        @hard.draw(640,500,0)
    end



    def needs_cursor?
        true
    end

    def button_down(id)
        if Gosu.button_down? Gosu::MS_LEFT
            option = gosOption(mouse_x,mouse_y) #find option based on mouse click
            if option
                close
                GameOfSet.new(option).show #Select option if button is clicked
            end
        else
          super
        end
      end
  end

WelcomePage.new.show
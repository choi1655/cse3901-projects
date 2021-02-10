
=begin
Class for card objects.
Card Naming Convention:
Shape:  a (circle), b (square), c (star)
Color:  i (black), j (orange), k (blue)
Shade:  x (solid), y (gradient), z (doted)
Number: 1,2,3

Note that this convention is matches the internal SVG of our assets.
We use templating to generate each of our cards, as well as the rasterized versions.
=end

class Card
    attr_reader :shape, :color, :number, :shade, :selected

    def initialize(shape, color, shade, number)
        @shape = shape
        @color = color
        @shade = shade 
        @number = number
        @selected = 0
    end

    #returns a string with four letters shape color shade number (scsn)
    def image
        return "media/"+@shape+@color+@shade+@number+".png"
    end

    #returns shade and color (Example: "yj")
    def xlink
        return @shape+@number
    end

    #returns shape and number as one string (Example: "b2")
    def class
        return @color+@shade
    end

    #Select/unselect card
    def select
        if @selected == 0
            @selected = 1
        else
            @selected = 0
        end
    end

    
    #String representation (for testing)
    def to_s
        "#{@shape} #{@color} #{@number} #{@shade}"
    end

end

require './backend/Utility.rb'
require './backend/GameState.rb'
require './backend/AiAgent.rb'
require './GameOver.rb'
require 'gosu'
include Utility

=begin
  This is the gui for the main game.
  Class GameOfSet initializes the back-end objects and generates the front-end elements.
=end

class GameOfSet < Gosu::Window

  
  #Parameter option represents the mode of the game (solo, two, AI, etc..) given by class WelcomePage
  def initialize(option)
    super 900, 750
    @font1 = Gosu::Font.new(25)
    @w = CARD_WIDTH
    @l = CARD_LENGTH
    self.caption = "Game of Set"

    #AI stays nil unless game mode involves a computer player
    @ai = nil

    #Game state
    @state = GameState.new(option)


    #Initilize images
    @images = [] #array that holds gosu images for cards on the field
    @hint = Gosu::Image.new("media/button_hint.png")
    @shuffle = Gosu::Image.new("media/button_shuffle.png")
    @player1 = Gosu::Image.new("media/button_player#1.png")
    @player2 = Gosu::Image.new("media/button_player#2.png")
    @computer = Gosu::Image.new("media/button_computer.png")

    #Initilize field
    for i in 0..11
      @state.field << @state.deck.draw
      if @state.field[i]
        @images << Gosu::Image.new(@state.field[i].image)
      end
    end

    #Players
    @state.players << Player.new(0) # first player's id 0
    case option #Other player's id 1 for second human, id 2 for AI
    when "two"
      @state.players << Player.new(1)
    when "easy"
      @state.players << Player.new(2)
      #Initialize AI
      @ai = AiAgent.new(3) #set difficulty, 3 for easy, 2 mid, 1 hard
    when "inter"
      @state.players << Player.new(2)
      @ai = AiAgent.new(2)
    when "hard"
      @state.players << Player.new(2)
      @ai = AiAgent.new(1)  
    end

    #Update initial stats after everything is initialized
    updateSetCount
  end
  


########################
#### Gosu Functions ####
########################

  #Gosu update function. Refreshes 60 times every second
  #Functions that require major processing should not be directly called here unless a condition is set
  def update
    if @state.turnTimer
      if @state.turnTimer < Time.now
        @state.currentPlayer.score -=1
        endTurn()
      end
    end

    #Request AI actions when it's a player, and the other player is not playing
    if @ai
      if @state.currentPlayer == nil
        playAI
      elsif @state.currentPlayer.id == 2
        callAI
      end
    end
    
    #Keep updating card images to reflect changes on field
    updateImage

    #Check if selected cards form a set.
    #Draw three more cards if it's set, otherwise unselect.
    if @state.set.length == 3
      if checkSet(@state.field[@state.set[0]],@state.field[@state.set[1]],@state.field[@state.set[2]])
        @state.currentPlayer.score+=1
        for cardNumber in @state.set
          if @state.deck.remain?
            @state.field[cardNumber] = @state.deck.draw
          else
            @state.field[cardNumber] = nil
          end
        end
        @state.set.clear
      else
        @state.currentPlayer.score-=1
      end
      endTurn() #End turn when a player selects 3 cards, regardless of outcome
    end

  end
  
  #Gosu draw function. Refreshes 60 times every second
  #All elements that show in the game, are generated here.
  def draw
    #Show time
    @font1.draw_text("Time: #{gameTime(@state.startTime)}", 690, 500, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)

    #Show number of cards left in deck
    @font1.draw_text("Cards left: #{@state.deck.remain?}", 690, 530, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    
    #Show number of sets on field/deck
    @font1.draw_text("Field: #{@state.fieldSets} sets", 690, 560, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    @font1.draw_text("Deck: #{@state.deckSets} sets", 690, 590, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    
    #Show scores
    @font1.draw_text("Player#1: #{@state.players[0].score} sets", 690, 620, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    
    #Show turn timer
    if @state.turnTimer
      @font1.draw_text("Play within: #{(@state.turnTimer - Time.now).round(2)}", 670, 50, 0, scale_x = 1, scale_y = 1, color = 0xff_ff0000, mode = :default)
    end
    #if there's scond player
    if @state.players[1]
      if @state.players[1].id == 1
        @font1.draw_text("Player#2: #{@state.players[1].score} sets", 690, 650, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
      end
      if @state.players[1].id == 2
        @font1.draw_text("Computer: #{@state.players[1].score} sets", 690, 650, 0, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
      end
    end

    #Show selected borders (for the current player)
    if @state.currentPlayer
      if @state.currentPlayer.id == 0
        draw_rect(650-5, 100-5, 198 +10, 66+10,0xff_00ff00, z = 0, mode = :default)
      end
    
      if @state.currentPlayer.id == 1
        draw_rect(650-5, 200-5, 202 +10, 66+10,0xff_00ff00, z = 0, mode = :default)
      end

      if @state.currentPlayer.id == 2
        draw_rect(640-5, 200-5, 219 +10, 66+10,0xff_00ff00, z = 0, mode = :default)
      end
    end

    #Show buttons
    @player1.draw(650,100,0)
    @hint.draw(680,300,0)
    @shuffle.draw(663,380,0)

    if @state.players[1]
      if @state.players[1].id == 1
        @player2.draw(650,200,0)
      end
      if @state.players[1].id == 2
        @computer.draw(640,200,0)
      end
    end
    
    #Check for changes in selected images, draw border if card is selected
    for i in 0..11
      if @images[i] and @state.field[i]
        position = position(i)
        if @state.field[i].selected == 1
          draw_rect(position[0]-5, position[1]-5, @w +10, @l+10, 0xff_ff0000, z = 0, mode = :default)
        end
        @images[i].draw(position[0],position[1],0)
      end
    end

  end

  #Gosu: Show mouse cursor
  def needs_cursor?
    true
  end
  
  #Gosu: actions when input is received (mouse, keyboard, etc..)
  def button_down(id)

    if(Time.now - @state.startTime > 0.5) #Delay start of game 0.5 seconds to insure smooth transition between windows
      if id == Gosu::KB_ESCAPE #close game escape button
        close
      elsif Gosu.button_down? Gosu::MS_LEFT

          clickType = identifyClick(mouse_x,mouse_y) #identify if card/button is pressed

          #Perform actions based on what is clicked
          if clickType == "hint"
            if @state.currentPlayer
              if @state.currentPlayer.id != 2
                deSelect() #Deselect all cards when hint is generated
                hint = hint(@state.field)
                if hint
                  selectUnselect(hint) #select the hint only when there's a hint
                end
              end
            else
              deSelect()
              hint = hint(@state.field)
              if hint
                selectUnselect(hint)
              end
            end
          elsif clickType == "shuffle" #refresh the field on shuffle
            if @state.currentPlayer == nil
              refreshField
            end
          #Select currentPlayer if there is no current player
          elsif clickType == "player1"
            if @state.currentPlayer == nil
              startTurn(0)
            end
          elsif clickType == "player2" and @state.option == "two"
            if @state.currentPlayer == nil
              startTurn(1)
            end

          #Select cards only when there's a current player. Cards are numbers in clickType
          elsif clickType.is_a? Integer and @state.currentPlayer
            if @state.currentPlayer.id != 2
              selectUnselect(clickType)
            end
          end


      else
        super
      end
    end
  end



########################
### Helper Functions ###
########################

  #Updates stats in state for how many sets are possible in field and deck
  def updateSetCount
    @state.fieldSets = countSets(@state.field)
    @state.deckSets = countSets(@state.deck.deck)
  end
  #Update Gosu image objects (for cards) to reflect changes on field
  def updateImage
    for i in 0..11
      if @images[i] and @state.field[i]
        @images[i] = Gosu::Image.new(@state.field[i].image)
      end
    end
  end

  #Unselect all cards on field
  def deSelect()
    for cardNumber in @state.set
      @state.field[cardNumber].select
    end
    @state.set.clear
  end



  #Select card if unselected and vice versa
  #Keep selecting until you have 3 selected cards, then clear.
  def selectUnselect(cardNumber)
      if @state.set.length < 3 and @state.field[cardNumber].selected == 0
        @state.field[cardNumber].select
        @state.set << cardNumber
      elsif @state.field[cardNumber].selected == 1
        @state.set.delete(cardNumber)
        @state.field[cardNumber].select
      else
        @state.set.clear
      end
  end

end

#Shuffle deck by returning cards to it, then drawing 12 cards again.
def refreshField
  deSelect
  for i in 0..11
    if @state.field.length != 0 #stop returning cards if less than 12 cards are on field
      @state.deck.return(@state.field.pop)
    end
  end
  @state.deck.shuffleDeck
  for i in 0..11
    if @state.deck.remain? > 0 #stop drawing if cards in deck are 0
      @state.field << @state.deck.draw
    end
  end
  updateSetCount
end



########################
### Turn Management ####
########################

#Select current player and turn timer if turn starts
def startTurn(id)
  deSelect
  @state.currentPlayer = @state.players[id]
  @state.turnTimer = Time.now + 7 #7 seconds to finish turn
end

#Undo what start turn does
def endTurn
  @state.currentPlayer = nil
  @state.turnTimer = nil
  deSelect
  updateSetCount
  endGame #Check if game is over
  if @ai #Update new Ai time
    @ai.aiTime = Time.now
  end
end

#Endgame if no sets are left in deck
def endGame
  if @state.deckSets == 0
    scores = []
    scores << @state.players[0].score
    if @state.players[1]
      scores << @state.players[1].score
    end
    #Go to GameOver window to show stats
    GameOver.new(scores, gameTime(@state.startTime)).show
    close
  end
end



########################
#### AI Management #####
########################

#Request AI decision and select cards
def callAI
  if Time.now - @ai.aiTime > 1.5 #Keep 1.5s segments before AI turns to show selected cards
    nextCard = @ai.nextCard(@state.field)
    if nextCard
      selectUnselect(nextCard)
      @ai.aiTime = Time.now
      if @ai.count == 3
        @ai.count = 0
      end
    else
      #If 0 sets on field, refresh the field (shuffle)
      refreshField
    end
  end
end

#Checks if AI has waited enough to play based on difficulty
def playAI
  if Time.now - @ai.aiTime > @ai.difficulty
    @ai.aiTime = Time.now
    startTurn(1)
  end
end
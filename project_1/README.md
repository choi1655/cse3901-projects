# Project 1 - Set Game in Ruby


## Game Description:

This is a virtual interpretation of the card game Set. The game can be played in single player or multiplayer against another human or against an AI with three levels of difficulty.

The score system is time/set based and the player must declare their turn by clicking on their assigned player name (player1 and player2). The players have 7 seconds to declare a set on the playing field to score a point and if they fail, they will be deducted a point. 

The interactive playing environment also offers players hints to a set and how many sets are currently being displayed amd there is a shuffle option to place all new cards on the playing field.

Finally, when the game finish, a stats page appears.


## Game Setup Instructions:

The [gosu](https://rubygems.org/gems/gosu/versions/0.10.7) gem is required to run the GUI environment of this project. 

#### Linux users
Before installing the gosu gem, install its dependencies by running the following command:
```sh
$ sudo apt-get install build-essential libsdl2-dev libgl1-mesa-dev libopenal-dev libsndfile-dev libmpg123-dev libgmp-dev libfontconfig1-dev
```
Then install the gosu gem itself
```sh
$ gem install gosu
```

To run the game:
```sh
$ ruby gos.rb
```

The game of Set will launch.

#### Windows users

Install the gosu gem
```sh
$ gem install gosu
```

To run the game:
```sh
$ ruby gos.rb
```

The game of Set will launch.

## Game Modes

#### Singleplayer

The singleplayer option provides the user with a game of Set with no oppenents. The game clock begins as soon as the playing field is displayed. The user will have unlimited time to scan the field for a set but as soon as they click the assigned player 1 name, they will have 7 seconds to select a set of three cards. If the user doesn't select the cards in the alloted time or selects an incorrect set, they will be deducted one point. If the user does select a set in the alloted time they will recieve one point. The game will continue until all cards have been expired from the deck.

#### Multiplayer:
 
To play Set with a friend select the two players button on the main menu. You may decide who will go first and then take turns trying to find a set. When you're ready to begin player 1 will select their name on the right of the screen and then try to to find a set in 7 seconds. After player 1 has taken their turn, player 2 must select their name and take their turn. This process will continue until all the sets in the deck have been found. The hint button can be used by either player if they need help finding a set, and the cards can be shuffled if there is no set in the playing field. Each set found is 1 point and each turn a player either doesn't find a set in time or guesses a set incorrectly, they lose 1 point. The winner is determined at the end by the player with the highest score.The players may then start up a new game if they wish.

#### Playing against AI:

If you'd like to play against the computer instead, you may do so by choosing one of the difficulties at the bottom of the main menu. These difficulties adjust how long it takes the computer to find a set, with easy being 21 seconds, medium being 14 seconds,and hard being 7 seconds. Try to find more sets quickly before the AI finds them first.

## Code Architecture 
#### Back-end
To build a scalable and generalizable code, all physical entities that exist in the Game of Set are replaced by virtual entities as classes (Deck, Card, Player, etc..) All these entities are initialized inside a GameState object. There’s one deck for each game and each deck contains 81 cards at the start of a game. Players are initialized based on the game mode. The AI agent is only initialized when the game mode includes a computer player. The Utility module includes functions that are used multiple times across the project.

#### Front-end
The front-end portion consists of three windows: WelcomePage, GameOfSet, and GameOver.
Front-end is based on the [gosu](https://rubygems.org/gems/gosu/versions/0.10.7) gem and its functions. Gosu functions like update, draw, and button_down are updated 60 times every second. It’s worth mentioning that heavy processes are never called directly inside these functions unless they pass a well-defined condition


## References:

* https://en.wikipedia.org/wiki/Set_(card_game)
* Cmglee, 2018, Set Cards, Wikipedia, October 1, 2020, <https://commons.wikimedia.org/wiki/File:Set_isomorphic_cards.svg>
  * Used as asset, under CC BY-SA 4.0 license.
* https://github.com/gosu/gosu/wiki/Ruby-Tutorial



## Team
#### Front End Team
* Dominik Winecki.1
* John Choi.1655
* Haoran (Randall) Jiang.1818

#### Back End Team
* Nawras Alnaasan.1
* Alec Juergens.27
* Mike McDaniel.619

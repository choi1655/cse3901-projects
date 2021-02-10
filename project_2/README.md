# Project 2 - Game of Set in JS

## Game Setup Instructions:
To run the game, simply open the Gos.html file on any browser.

## Playing Instructions
After opening Gos.html, the game starts. The user has three options, hint, shuffle, and replay. 
##### Hint:
Hint will give the user up to two hints by selecting the cards. However, the first hint will penalize the player for 0.25 pts, the second hint will penalize for 0.5 pts. If there are not sets on the field, no hint is given.
##### Shuffle:
Shuffle is mainly used when the player cannot find any more sets on the field. It draws new cards from the deck at the cost of a small penalty.
##### Replay:
Starts a new game.

## Code Architecture 
#### Backend

A simple `Card` class to be used for storing the properties of a card, used as a struct more than anything.

A `Game` class that represents the state of the game.

#### Controller/View

AngulerJS is used in this project for managing both the view an controller. As user interacts with interface of the game, the game state backend is updated using the AnuglarJS controller. Angular is very dynamic and allows for instant updating of changes.

#### Styles

The .css styles used in the game of set are used to better organize and enhance the game display in an html environment. There are different container classes implemented to create a grid for the playing field, styling of buttons, and auto scaling for different sizes of browsers. All the .css styles are located in the style.css file and are linked to the html page for reference.


## References:

* The `_shuffle` function was taken from StackOverflow:
    * Source: https://stackoverflow.com/questions/6274339/how-can-i-shuffle-an-array
    * Licenced under CC BY-SA 3.0 (https://creativecommons.org/licenses/by-sa/3.0/).
        * (Note that the source was contributed over the years 2016-2017 so this is the older licence)


* CSS Styles Inspirtation
	* Source: https://www.youtube.com/watch?v=28VfzEiJgy4

## User Interface Team:
* Nawras Alnaasan.1
* John Choi.1655

## CSS/Style Team:
* Mike McDaniel.619
* Alec Juergens.27

## Game Engine Team:
* Dominik Winecki.1
* Haoran (Randall) Jiang.1818


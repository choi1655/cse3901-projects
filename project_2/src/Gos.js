// Set game library

/*
    Card
*/

const SHAPES = ["a", "b", "c"];
const COLORS = ["i", "j", "k"];
const SHADES = ["x", "y", "z"];
const NUMBERS = ["1", "2", "3"];

/**
 * Class that represents a game card.
 * Defines shape, color, shade, number, image, and the toggle for selecting this
 * card.
 */
class Card {

    /**
     * Constructor for this class.
     * Creates a card with a passed in shape, color, shade, and number and
     * initializes the selected state to false.
     */
    constructor(shape, color, shade, number) {
        this.shape = shape;
        this.color = color;
        this.shade = shade;
        this.number = number;

        // hey other teams
        // use this
        // we promise not to touch it
        this.selected = false;
    }

    //return a string with four letters shape color shade number
    image() {
        return "media/" + this.shape + this.shade + this.color + this.number + ".png";
    }

    //select/unselect card
    select() {
        this.selected = !this.selected;
    }

    //represent card variable as string
    toString() {
        return "" + this.shape + this.color + this.shade + this.number;
    }

}

/**
 * Creates the deck of cards and returns.
 * Creates a card for each shapes, colors, shades, and numbers.
 */
function _createDeck() {
    let deck = [];

    SHAPES.forEach((shape) => {
        COLORS.forEach((color) => {
            SHADES.forEach((shade) => {
                NUMBERS.forEach((number) => {
                    deck.push(new Card(shape, color, shade, number));
                });
            });
        });
    });
    return deck;
}


/*
    Externally provided code to shuffle an array in-place.
    Uses Fisher-Yates algorithm: https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#The_modern_algorithm

    Source: https://stackoverflow.com/questions/6274339/how-can-i-shuffle-an-array
    Licenced under CC BY-SA 3.0 (https://creativecommons.org/licenses/by-sa/3.0/).
    (Note that the source was contributed between 2013-2016 so this is the older licence)
*/
/**
 * Shuffles array in place.
 * @param {Array} a items An array containing the items.
 */
function _shuffle(a) {
    var j, x, i;
    for (i = a.length - 1; i > 0; i--) {
        j = Math.floor(Math.random() * (i + 1));
        x = a[i];
        a[i] = a[j];
        a[j] = x;
    }
    return a;
}

/*
    Game
*/

/**
 * Game class that handles the current game state.
 * Contains most of the logics and state for the game.
 */
class Game {

    /**
     * Constructor for this class.
     * Initializes the global variables/attributes.
     */
    constructor(on_win, on_bad_select) {
        this._start_tm = new Date();
        this._deck = _createDeck();

        this._field = [];
        this._on_win = on_win;
        this._on_bad_select = on_bad_select;
        this._score = 0;

        _shuffle(this._deck);
        for (let i = 0; i < 12; i++) {
            this._field.push(this._deck.pop());
        }
    }

    /**
     * Returns the index within field of a card with a set.
     * Or, if it can't find one, returns null.
     */
    hint() {
        for (const [idx1, val1] of this._field.entries()) {
            for (const [idx2, val2] of this._field.entries()) {
                for (const val3 of this._field) {
                    if ((val1.toString() != val2.toString()) && (val1.toString() != val3.toString()) && (val2.toString() != val3.toString())) {
                        if (this.checkSet([val1, val2, val3])) {
                            return [idx1, idx2];
                        }
                    }
                }
            }
        }
        return null;
    }

    drawCards() {
        // the numbers are always divisble by 3 so don't worry about edge cases here
        if (this._deck.length > 0) {
            this._field.push(this._deck.pop());
            this._field.push(this._deck.pop());
            this._field.push(this._deck.pop());
        }
    }

    checkSet(set) {
        // set is an array
        for (let i = 0; i < 4; i++) {
            let variant_set = new Set();
            set.forEach((element) => variant_set.add(element.toString()[i]));
            if (variant_set.size < set.length && variant_set.size != 1) {
                return false;

            }
        }

        return true;
    }

    playSet(set) {
        // set contains 3 cards
        // play the state with them
        // if the user wins, call this._on_win
        // if the set is bad, call this.on_bad_select

        if (this._isGameWon()) {
            this._on_win();
            return;
        }
        if (!this.checkSet(set)) {
            this._on_bad_select();
            return;
        }

        this._score++;
        // remove from field
        set.forEach((card) => {
            this._field.splice(this._field.indexOf(card), 1);
        });

        if (this._deck.length == 0) {
            this._on_win();
            return;
        }

        this.drawCards();
    }

    /**
     * Returns an object containing multiple game information like deck size,
     * field (deck), game time, and score.
     */
    getField() {
        return {
            deck_size: this._deck.length,
            field: this._field,
            game_time: this._start_tm,
            score: this._score
        };
    }

    //return true if no more valid sets remain in deck and field
    _isGameWon() {
        let s = [];
        for (let i = 0; i < this._field.length; i++) {
            s.push(this._field.indexOf(i));

        }
        for (let j = 0; j < this._deck.length; j++) {
            s.push(this._deck.indexOf(j));
        }
        for (let a = 0; a < s.length; a++) {
            for (let b = a + 1; b < s.length; b++) {
                for (let c = b + 1; c < s.length; c++) {
                    if (this.checkSet([s[a], s[b], s[c]])) {
                        return false;
                    }
                }
            }
        }
        return true;
    }

    shuffle_process() {
        while (this._field.length) {
            this._deck.push(this._field.pop());
        }
        _shuffle(this._deck);
        for (let i = 0; i < 4; i++) {
            this.drawCards();
        }
    }
}

/** Angular framework reference */
var gos = angular.module('gos', []);

/**
 * Controller for the user interface elements.
 * Defines the behaviors of the user interface elements (buttons)
 * and keeps and updates the game state.
 */
gos.controller('gameCtrl', function ($scope, $interval) {

    /**
     * The reference to the game object that keeps the state of the game, such
     * as the score, time, hint, deck, etc.
     */
    game = new Game(win, badSelect);

    user_select_count = 0;
    hint_select_count = 0;
    selectedCards = [] // The list of cards that are selected
    startTime = game.getField().game_time;

    $scope.gos = "Game of Set!"; // Title/header of the page
    $scope.text = "";
    $scope.selected = "";
    $scope.field = game.getField().field;
    $scope.time = 0;
    $scope.deck_left = game.getField().deck_size;
    $scope.score = game.getField().score;
    time();
    $interval(time, 10);

    /**
     * Name: hint()
     * Finds two cards and selects them one by one.
     * On the first call of this function, the score penalty of 0.25 is applied.
     * On the second hint request, the score penalty of additional 0.5 is applied.
     */
    $scope.hint = function () {
        if (user_select_count != 0) {
            refreshField();
        }

        if (game.hint() != null) {
            //Two step hint logic
            if (hint_select_count == 0) {
                game._score -= 0.25;
                $scope.score = game.getField().score;

                index = game.hint()[0];
                $scope.field[index].select();
                selectedCards.push($scope.field[index]);
                hint_select_count++;
            }
            else if (hint_select_count == 1) {
                game._score -= 0.5;
                $scope.score = game.getField().score;

                index = game.hint()[1];
                $scope.field[index].select();
                selectedCards.push($scope.field[index]);
                hint_select_count++;
            }
        }
    };

    /**
     * Refreshes the game state and shuffles the cards.
     */
    $scope.shuffle = function () {
        refreshField();
        game.shuffle_process();
    };

    /**
     * Returns the appropriate card style for the current state of the passed in
     * card. If the card is selected, return the red borderline, else return
     * white borderline.
     */
    $scope.cardStyle = function (card) {
        if (card.selected) {
            return '4px solid red';
        }
        else {
            return '4px solid white'
        }
    }

    $scope.reload = function () {
        location.reload();
    }

    /**
     * Defines the behavior for clicking on the card.
     * Selects the card if the card is unselected, unselects the card if it was
     * selected. Checks the total number of selected cards and if 3 cards are
     * selected, the function checks to see if they are valid set. Refreshes
     * the game.
     */
    $scope.imageClicked = function (index) {
        $scope.selected = index;
        $scope.field[index].select();
        if (hint_select_count != 0) {
            user_select_count += hint_select_count;
            hint_select_count = 0;
        }
        if ($scope.field[index].selected) { //select
            user_select_count++;
            selectedCards.push($scope.field[index]);
            if (selectedCards.length == 3) {
                game.playSet(selectedCards);
                refreshField();
            }
        }
        else //unselect
        {
            user_select_count--;
            selectedCards.splice(selectedCards.indexOf($scope.field[index]), 1);
        }
    };


    /**
     * Reset field variables before/after an event.
     */
    function refreshField() {
        $scope.field.forEach((card) => card.selected = false);
        selectedCards = [];
        user_select_count = 0;
        hint_select_count = 0;
        $scope.deck_left = game.getField().deck_size;
        $scope.score = game.getField().score;
    }

    /**
     * Calculates the elapsed time and sets the global time variable.
     */
    function time() {
        $scope.time = Date.now() - startTime;
    }

    /**
     * This function is called when the bad set is selected.
     * Deducts a point off from the score and refreshes the game.
     */
    function badSelect() {
        game._score--;
        refreshField();
    }

    /**
     * This function is called when the win condition is met.
     * Displays the win message and reloads the game.
     */
    function win() {
        window.alert("Game over!\nFinal score: "+$scope.score+" pts.\nTotal time: "+$scope.time/1000+" s.\nPress Ok to start a new game.\nThanks for playing Game of Set!\nDesign by SlackOverflow CSE3901.");
        $scope.reload();
    }
});

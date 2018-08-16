# BS Poker Calculator

This project was created to do a statistical analysis of the game BS poker. BS poker is a card game with rules as follows. A set number of cards is dealt to each player. The players go around a circle calling out higher and higher poker hands, trying to guess which poker hands can be adequately formed using the cards pooled together by all the players. Then when one player calls BS, all cards are revealed. If the last claim was true, the player who called BS loses. If it was false, the player who was convicted of BS loses. "Spot on" can also be called if the player thinks that the previous call was the highest possible call. If so, the previous player loses. However, if the call does not exist or a higher call exists, then the caller loses.

If a player loses a round, they start with 1 additional card during the next rounds. If a player loses with 4 cards in hand, they are out. The last person left in the game wins.

To increase the odds of high hands, 2s are wild cards that can change to any other number (but they stay the same suit for flushes).

Here is the final ranking: probability we decided to use based on these results (based on a 15 card hand, 6 wilds, and 10000 simulations). 
* Ten of a Kind: 0.0001
* Nine of a Kind: 0.0001
* Eight of a Kind: 0.0027
* Spaceship: 0.0081
* Long Straight Flush: 0.0009
* Seven of a Kind: 0.0243
* Skyscraper: 0.0615
* Six of a Kind: 0.1317
* Straight Flush: 0.1229
* FiveFive of a Kind: 0.4091
* Boat: 0.4277
* Long Straight: 0.7295
* Four of a Kind: 0.7698
* Full House: 0.963
* Three of a Kind: 0.963
* Flush: 0.9156
* Straight: 0.9646
* Two Pair: 1.0
* Pair: 1.0
* High Card: 1.0

Note that straight flush, long straight flush, and joker are out of order from their probability. This is because we play with the two additional wilds as jokers, which change suit and make all flushes significantly more likely. 

## Setup

### Requirements

* tested on ruby 2.3.1. Not guaranteed to work on other versions
* install ruby
* use `bundle` while in the directory with the Gemfile to install the dependencies.
* The number of wilds can be changed by changing the `num_wilds` variable in the generate_statistics.rb file. However, as the default implementation of decks in rubycards has a read-only deck, it is not possible to add new cards to the deck without changing this feature. 
    * To do so, navigate to the rubycards directory locally (for me it was `cd /var/lib/gems/2.3.0/gems/rubycards-0.0.4/lib/rubycards`), then edit the `deck.rb` file and add the line `attr_writer :cards` right after the line `attr_reader :cards`. This will make the deck editable so that new cards can be added.

## Use

* `ruby generate_statistics.rb` to start the simulations. It will ask for a number of simulations and cards in hands.
* If the `deck.rb` file was changed as in the setup, then num_wilds can be changed to add more wilds. Otherwise, the default is 4.

### Alternate Game types

We have been experimenting with various game types to mess around with the game. Here are some of the variants:

* Blackjack BS poker: start each round with faceup cards equal to the number of players. These are used for all players calls. First turn play calls tend to start much higher, and games typically take longer, so it is suggested to only play to 3 cards before they are out.

* BS poker Hold 'Em: Start each round with facedown cards equal to the number of players. All cards are used for players calls, including face down ones. Each time someone starts their turn, flip one card up unless all of them are already flipped. This tends to stop the ridiculous calls at the start, and games still take a while. 3 card max suggested.

* BS poker Nile River: Every time someone starts their turn, flip a card from the top of the deck. It is very important that players do not "limp" (make significantly weaker calls than can be made) or the game will devolve into calling the highest possible long straight and getting spotted. This also means ridiculous calls can happen during the first round, which is hilarious.

## Acknowledgements:
* I found out later that <https://github.com/jenniezheng/BS_Poker_Chances_Calculator> accomplishes a similar task to what I was trying to accomplish. This solution is written in ruby with much fewer files, so it might be simpler for some people to follow. In addition, we play with 2s that do not change suit, and with a number of higher possible calls. However, Jennie's appears to be more robust overall in terms of functionality, and has an associated website. Very impressive project!

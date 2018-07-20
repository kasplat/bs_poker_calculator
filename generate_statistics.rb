# Generate the statistics for the bs poker to find the most common hands based on how many cards are seen
require_relative "./bs_poker_hands/bs_poker_hands.rb"
require 'gruff'

num_simulations = 10000
# num_cards_in_hand = 2  # unused right now
num_cards_total = 5
possible_hands_dict = Hash.new(0)


(1..num_simulations).each do |i|
    deck = Deck.new()
    hand = Hand.new()
    deck.shuffle!
    hand.draw(deck, num_cards_total)
    if n_of_a_kind(hand, 2)
        possible_hands_dict['Pair'] += 1
    end
    if n_pair(hand, 2)
        possible_hands_dict['Two Pair'] += 1
    end
    if n_of_a_kind(hand, 3)
        possible_hands_dict['Three of a Kind'] += 1
    end
    if straight(hand)
        possible_hands_dict['Straight'] += 1
    end
    if flush(hand)
        possible_hands_dict['Flush'] += 1
    end
    if full_house(hand)
        possible_hands_dict['Full House'] += 1
    end
    if n_of_a_kind(hand, 4)
        possible_hands_dict['Four of a Kind'] += 1
    end
    if straight_flush(hand)
        possible_hands_dict['Straight Flush'] += 1
    end
    if n_of_a_kind(hand, 5)
        possible_hands_dict['Five of a Kind'] += 1
    end
end


g = Gruff::Bar.new
g.title = 'BS Poker Hand Counts'
g.labels = possible_hands_dict


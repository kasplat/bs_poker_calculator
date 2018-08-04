# Generate the statistics for the bs poker to find the most common hands based on how many cards are seen
require_relative "./bs_poker_hands/bs_poker_hands.rb"
require 'pp'

num_simulations = 10000
# num_cards_in_hand = 2  # unused right now
num_cards_total = 12
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
    if straight(hand, 5)
        possible_hands_dict['Straight'] += 1
    end
    if straight(hand, 8)
        possible_hands_dict['Long cock'] += 1
    end
    if flush(hand)
        possible_hands_dict['Flush'] += 1
    end
    if n_over_m(hand, 3, 2)
        possible_hands_dict['Full House'] += 1
    end
    if n_of_a_kind(hand, 4)
        possible_hands_dict['Four of a Kind'] += 1
    end
    if straight_flush(hand, 5)
        possible_hands_dict['Straight Flush'] += 1
    end
    if n_of_a_kind(hand, 5)
        possible_hands_dict['Five of a Kind'] += 1
    end
    if n_of_a_kind(hand, 6)
        possible_hands_dict['Six of a Kind'] += 1
    end
    if n_of_a_kind(hand, 7)
        possible_hands_dict['Seven of a Kind'] += 1
    end
    if n_of_a_kind(hand, 8)
        possible_hands_dict['Eight of a Kind'] += 1
    end
    if n_of_a_kind(hand, 9)
        possible_hands_dict['Nine of a Kind'] += 1
    end
    if n_of_a_kind(hand, 10)
        possible_hands_dict['Ten of a Kind'] += 1
    end
    if n_over_m(hand, 4, 3)
        possible_hands_dict['Boat'] += 1
    end
    if n_over_m(hand, 5, 4)
        possible_hands_dict['Skyscraper'] += 1
    end
    if n_over_m(hand, 6, 5)
        possible_hands_dict['Spaceship'] += 1
    end
end

possible_hands_dict.each do |key, value|
    possible_hands_dict[key] /= 10000.0
end

pp possible_hands_dict.sort_by { |key, value| value }

# pp possible_hands_dict


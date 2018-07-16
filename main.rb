require 'rubycards'
include RubyCards

def two_of_a_kind(hand)
    pair_dict = {}
    hand.each do |card|
        if pair_dict[card.rank]
            return true
        end
        pair_dict[card.rank] = true
    end
    return false
end
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

pair_aces = Hand.new([Card.new('Ace', 'Hearts'), Card.new('Ace', 'Clubs')])
puts two_of_a_kind(pair_aces)
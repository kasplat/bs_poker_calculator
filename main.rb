require 'rubycards'
include RubyCards


def n_of_a_kind(hand, n)
    hand_dict = {}
    hand.each do |card|
        if hand_dict[card.rank] == n - 1
            return [true, card.rank]
        else
            if hand_dict[card.rank]
                hand_dict[card.rank] += 1
            else
                hand_dict[card.rank] = 1
            end
        end
    end
    return [false, '0']
end

def n_pair(hand, n)
    hand_dict = {}
    hand.each do |card|
        if hand_dict[card.rank]
            hand_dict[card.rank] += 1
        else
            hand_dict[card.rank] = 1
        end
    end

    pairs = []
    hand_dict.each do |key, value|
        if value >= 2
            pairs.push(key)
            if pairs.length == n
                return pairs
            end
        end
    end
    return false

end


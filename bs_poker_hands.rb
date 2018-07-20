# the functions for bs poker hands (2s are wilds)
require 'rubycards'
include RubyCards


def n_of_a_kind(hand, n)
    hand_dict = get_hand_dict_nums(hand)
    if !hand_dict[2]
        hand_dict[2] = 0
    end
    hand_dict.each do |key, value|
        if value + hand_dict[2] >= n
            return [true, key]
        end
    end
    return false
end

def n_pair(hand, n)
    hand_dict = get_hand_dict_nums(hand)
    pairs = []
    if !hand_dict[2]
        hand_dict[2] = 0
    end
    hand_dict.each do |key, value|
        next if key == 2
        if value >= 2
            pairs.push(key)
        elsif value == 1 and hand_dict[2] > 0  # if there is exactly 1 2
            hand_dict[2] -= 1
            pairs.push(key)
        end
        if pairs.length == n
            return pairs
        end
    end
    while hand_dict[2] >= 2
        hand_dict -= 2
        pairs.push(2)
    end
    return false

end

def straight(hand)
    hand.sort!()
    recent = false
    current_length = 1
    hand.each do |card|
        if recent
            if recent.rank.to_i == card.rank.to_i - 1
                current_length += 1
                if current_length == 5
                    return [true, card.rank]
                end
            elsif card.rank.to_i != recent.rank.to_i
                current_length = 1
            end
        end
        recent = card
    end
    return false
end

def flush(hand)
    hand_dict = {}
    hand.each do |card|
        if hand_dict[card.suit] == 4
            return [true, card.suit]
        else
            if hand_dict[card.suit]
                hand_dict[card.suit] += 1
            else
                hand_dict[card.suit] = 1
            end
        end
    end
    return false
end

def full_house(hand)
    hand_dict = get_hand_dict_nums(hand)

    three_of_a_kind = false
    two_of_a_kind = false
    hand_dict.each do |key, value|
        if value >= 3 and not three_of_a_kind
            three_of_a_kind = key
        elsif value >= 2
            two_of_a_kind = key
        end 
    end
    if three_of_a_kind and two_of_a_kind
        return [three_of_a_kind, two_of_a_kind]
    else
        return false
    end
end

def straight_flush(hand)
    hand_dict = {}
    hand.sort!()
    recent = false
    current_length = 1
    hand.each do |card|
        if recent
            if card.suit == recent.suit and card.rank.to_i - 1 == recent.rank.to_i
                current_length += 1
                if current_length == 5
                    return [true, card.rank, card.suit]
                end
            elsif card.rank.to_i != recent.rank.to_i
                current_length = 1
            end
        end
        recent = card
    end
    return false
end

def get_hand_dict_nums(hand)
    hand_dict = {}
    hand.each do |card|
        if hand_dict[card.rank]
            hand_dict[card.rank] += 1
        else
            hand_dict[card.rank] = 1
        end
    end
    return hand_dict
end
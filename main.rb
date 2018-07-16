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

def straight(hand)
    hand.sort!()
    recent = "0"
    current_length = 0
    hand.each do |card|
        if recent == card.rank.to_i - 1
            current_length += 1
            if current_length == 5
                return [true, card.rank]
            end
        else
            current_length = 1
        end
        recent = card.rank.to_i
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
    hand_dict = {}
    hand.each do |card|
        if hand_dict[card.rank]
            hand_dict[card.rank] += 1
        else
            hand_dict[card.rank] = 1
        end
    end

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

# the functions for bs poker hands (2s are wilds)
require 'rubycards'
include RubyCards


def n_of_a_kind(hand, n)
    hand_dict = get_hand_dict_nums(hand)
    hand_dict.each do |key, value|
        next if key == '2'
        if value + hand_dict['2'] >= n
            return [key]
        end
    end
    return false
end

def n_pair(hand, n)
    hand_dict = get_hand_dict_nums(hand)
    pairs = []
    hand_dict.each do |key, value|
        next if key == 2
        if value >= 2
            pairs.push(key)
        elsif value == 1 and hand_dict['2'] > 0  # if there is exactly 1 2
            hand_dict['2'] -= 1
            pairs.push(key)
        end
        if pairs.length == n
            return pairs
        end
    end
    while hand_dict['2'] >= 2
        hand_dict -= 2
        pairs.push(2)
    end
    return false

end

def straight(hand, straight_length)
    """
    Window through the straight length from 3 upward to check if straight exists
    """
    hand_dict = get_hand_dict_nums(hand)
    current_start = 3
    while current_start + straight_length - 1 <= 14  # if len == 1, go from 14 + 1 -1 to 14
        total = 0
        (current_start..current_start + straight_length - 1).each do |key|
            card_rank = get_rank(key)
            if hand_dict.has_key? card_rank
                total += 1
            end
        end
        if total + hand_dict['2'] >= straight_length
            return true
        end
        current_start += 1
    end
    return false
end

def get_rank(card_rank)
    # takes a card rank in an int and returns the string (for Jack - Ace)
    if card_rank < 11
        return card_rank.to_s
    end
    case card_rank
    when 11
        return "Jack"
    when 12
        return "Queen"
    when 13
        return "King"
    when 14
        return "Ace"
    end
end

def flush_of_n(hand, n)
    hand_dict = Hash.new(0)
    hand.each do |card|
        if hand_dict[card.suit] == n-1
            return [card.suit]
        else
            hand_dict[card.suit] += 1
        end
    end
    return false
end

def n_over_m(hand, n, m)
    hand_dict = get_hand_dict_nums(hand)

    n_of_a_kind = false
    m_of_a_kind = false
    # check for raw n-tuple and m-tuple so that 2s are not removed unless they need to be
    hand_dict.each do |key, value|
        next if value == 2
        if value >= n and not n_of_a_kind
            n_of_a_kind = key
        # elsif value >= m
        #     m_of_a_kind = key
        end
    end
    if !n_of_a_kind
        hand_dict.each do |key, value|
            if value + hand_dict['2'] >= n
                n_of_a_kind = key
                if hand_dict.has_key? '2'
                   hand_dict['2'] -= n - value  # if value is 2, reduce by 1 "2".
                end
                break
            end
        end
    end
    if !m_of_a_kind
        hand_dict.each do |key, value|
            next if key == n_of_a_kind or key == '2'
            if value + hand_dict['2'] >= m
                m_of_a_kind = key
                if hand_dict.has_key? '2'
                    hand_dict['2'] -= m - value
                end
            end
        end
    end
    if n_of_a_kind and m_of_a_kind
        return [n_of_a_kind, m_of_a_kind]
    else
        return false
    end
end

def straight_flush(hand, straight_length)
    ['Clubs', "Diamonds", 'Hearts', "Spades"].each do |current_suit|
        current_start = 3
        while current_start + straight_length - 1 <= 14  # if len == 1, go from 14 + 1 -1 to 14
            total = 0
            two_exists = hand.detect {|card| card.rank == '2' and card.suit == current_suit} ? 1 : 0  # 1 if it exists, else 0
            (current_start..current_start + straight_length - 1).each do |key|
                card_rank = get_rank(key)
                if hand.detect {|card| card.rank == card_rank and card.suit == current_suit}
                    total += 1
                end
            end
            if total + two_exists >= straight_length
                return true
            end
            current_start += 1
        end
    end
    return false
end

def get_hand_dict_nums(hand)
    hand_dict = Hash.new(0)
    hand.each do |card|
        hand_dict[card.rank] += 1
    end
    return hand_dict
end
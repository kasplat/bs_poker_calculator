# for testing the bs poker hands
require_relative "./bs_poker_hands.rb"
require "test/unit"

class TestPair < Test::Unit::TestCase
    
    def setup
        @pair_aces = Hand.new([Card.new('Ace', 'Hearts'), Card.new(2, 'Clubs')])
        @three_random = Hand.new([Card.new(3, 'Hearts'), Card.new('Ace', 'Hearts'), Card.new('Queen', 'Hearts')])
        @pair_aces_and_fives = @pair_aces.cards + [Card.new(5, 'Hearts'), Card.new(5, 'Clubs')]
        @triple_aces = @pair_aces.cards + [Card.new('Ace', 'Spades')]
        @small_straight = Hand.new([Card.new(3), Card.new(4), Card.new(5), Card.new(6)])
        @straight = @small_straight.cards + [Card.new(7)]
        @straight_with_two = @straight + [Card.new(2)]
        @four_spades_3_hearts = @three_random.cards + @small_straight.cards
        @three_aces_two_fives = @pair_aces_and_fives + [Card.new('Ace', 'Spades')]
        @four_aces_three_fives = @three_aces_two_fives + [Card.new('Ace', 'Spades')] + [Card.new(5, 'Clubs')]
        @high_straight = @three_random.cards + [Card.new('King', 'Spades')] + [Card.new('Jack', "Spades")] + [Card.new(10, 'Spades')]
    end

    def test_pair_true
        assert_equal(['Ace'], n_of_a_kind(@pair_aces, 2))
    end

    def test_pair_false
        assert_equal(false, n_of_a_kind(@three_random, 2))
    end

    def test_triple_true
        assert_equal(['Ace'], n_of_a_kind(@triple_aces, 3))
    end

    def test_triple_false
        assert_equal(false, n_of_a_kind(@small_straight, 3))
    end

    def test_1_pair_true
        assert_equal(['Ace'], n_pair(@pair_aces, 1))
    end

    def test_1_pair_false
        assert_equal(false, n_pair(@three_random, 1))
    end

    def test_2_pair_true
        assert_equal(['Ace', '5'], n_pair(@pair_aces_and_fives, 2))
    end

    def test_2_pair_false
        assert_equal(false, n_pair(@three_random, 2))
    end

    def test_straight_true
        assert_equal(true, straight(@straight, 5))
    end
    
    def test_straight_false
        assert_equal(false, straight(@small_straight, 5))
    end

    def test_straight_two_true
        assert_equal(true, straight(@straight_with_two, 5))
    end

    def test_high_straight_true
        assert_equal(true, straight(@high_straight, 5))
    end

    def test_flush_true
        assert_equal(["Spades"], flush_of_n(@straight, 5))
    end

    def test_flush_false
        assert_equal(false, flush_of_n(@four_spades_3_hearts, 5))
    end

    def test_full_house_true
        assert_equal(["Ace", "5"], n_over_m(@three_aces_two_fives, 3, 2))
    end

    def test_full_house_false
        assert_equal(false, n_over_m(@four_spades_3_hearts, 3, 2))
    end

    def test_straight_flush_true
        assert_equal(true, straight_flush(@straight, 5))
    end

    def test_straight_flush_false
        assert_equal(false, straight_flush(@small_straight, 5))
    end

    def test_4_over_3_true
        assert_equal(['Ace', '5'], n_over_m(@four_aces_three_fives, 4, 3))
    end

    def test_4_over_3_false
        assert_equal(false, n_over_m(@four_spades_3_hearts, 4, 3))
    end

end
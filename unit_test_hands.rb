require_relative "./main.rb"
require "test/unit"

class TestPair < Test::Unit::TestCase
    
    def setup
        @pair_aces = Hand.new([Card.new('Ace', 'Hearts'), Card.new('Ace', 'Clubs')])
        @three_random = Hand.new([Card.new(3, 'Hearts'), Card.new('Ace', 'Hearts'), Card.new('Queen', 'Hearts')])
        @pair_aces_and_fives = @pair_aces.cards + [Card.new(5, 'Hearts'), Card.new(5, 'Clubs')]
        @triple_aces = @pair_aces.cards + [Card.new('Ace', 'Spades')]
        @small_straight = Hand.new([Card.new(3), Card.new(4), Card.new(5), Card.new(6)])
        @straight = @small_straight.cards + [Card.new(7)]
        @four_spades_3_hearts = @three_random.cards + @small_straight.cards
        @three_aces_two_fives = @pair_aces_and_fives + [Card.new('Ace', 'Spades')]
    end

    def test_pair_true
        assert_equal([true, 'Ace'], n_of_a_kind(@pair_aces, 2))
    end

    def test_pair_false
        assert_equal([false, '0'], n_of_a_kind(@three_random, 2))
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

    def test_triple_true
        assert_equal([true, 'Ace'], n_of_a_kind(@triple_aces, 3))
    end

    def test_triple_false
        assert_equal([false, '0'], n_of_a_kind(@pair_aces_and_fives, 3))
    end

    def test_straight_true
        assert_equal([true, '7'], straight(@straight))
    end
    
    def test_straight_false
        assert_equal(false, straight(@small_straight))
    end

    def test_flush_true
        assert_equal([true, "Spades"], flush(@straight))
    end

    def test_flush_false
        assert_equal(false, flush(@four_spades_3_hearts))
    end

    def test_full_house_true
        assert_equal(["Ace", "5"], full_house(@three_aces_two_fives))
    end

    def test_full_house_false
        assert_equal(false, full_house(@four_spades_3_hearts))
    end

end
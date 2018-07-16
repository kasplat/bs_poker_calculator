require_relative "./main.rb"
require "test/unit"

class TestPair < Test::Unit::TestCase
    
    def setup
        @pair_aces = Hand.new([Card.new('Ace', 'Hearts'), Card.new('Ace', 'Clubs')])
        @three_random = Hand.new([Card.new(3, 'Hearts'), Card.new('Ace', 'Hearts'), Card.new('Queen', 'Hearts')])
        @pair_aces_and_fives = @pair_aces.cards + [Card.new(5, 'Hearts'), Card.new(5, 'Clubs')]
        @triple_aces = @pair_aces.cards + [Card.new('Ace', 'Spades')]
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

end
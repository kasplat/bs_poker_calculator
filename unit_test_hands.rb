require_relative "./main.rb"
require "test/unit"

class TestPair < Test::Unit::TestCase
    
    def setup
        @pair_aces = Hand.new([Card.new('Ace', 'Hearts'), Card.new('Ace', 'Clubs')])
        @three_in_a_row = Hand.new([Card.new('1', 'Hearts'), Card.new('Ace', 'Hearts'), Card.new('Queen', 'Hearts')])
    end

    def test_pair_true
        assert_equal(true, two_of_a_kind(@pair_aces))
    end

    def test_pair_false
        assert_equal(false, two_of_a_kind(@three_in_a_row))
    end

end
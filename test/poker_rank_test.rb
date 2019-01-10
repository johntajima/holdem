require "test_helper"

class PokerRankTest < Minitest::Test

  def setup

  end


  def test_detect_high_card
    cards = build_hand("2s Kd 4h 3h 8s 6d Jc")
    @pokerhand = Holdem::PokerRank.new(cards)
    
    assert_equal :high_card, @pokerhand.rank
    assert_equal 1, @pokerhand.score
    assert_equal "Kd", @pokerhand.key_cards.map(&:to_s).join(" ")
    assert_equal "Kd Jc 8s 6d 4h", @pokerhand.hand_as_string
  end

  # pair

  def test_detect_a_pair
    cards = build_hand("As Kd 4h 3h Ks 6d Jc")
    @pokerhand = Holdem::PokerRank.new(cards)

    assert_equal :pair, @pokerhand.rank
    assert_equal "Kd Ks", @pokerhand.key_cards.map(&:to_s).join(" ")
    assert_equal 2, @pokerhand.score
  end


  # two pair

  def test_detect_two_pair
    cards = build_hand("4h 3h 3s 6d 6c Th Qs")
    @pokerhand = Holdem::PokerRank.new(cards)

    assert_equal :two_pair, @pokerhand.rank
    assert_equal "6d 6c 3h 3s Qs", @pokerhand.hand_as_string
    assert_equal 3, @pokerhand.score
  end

  def test_detect_two_pair_picks_highest_two_pair_and_right_kicker
    cards = build_hand("Ah 3h 3s 6d 6c Th Ts")
    @pokerhand = Holdem::PokerRank.new(cards)

    assert_equal :two_pair, @pokerhand.rank
    assert_equal "Th Ts 6d 6c Ah", @pokerhand.hand_as_string
    assert_equal 3, @pokerhand.score
  end


  # three_kind

  def test_detect_three_of_a_kind
    cards = build_hand("As Kd 4h 3h 3s 6d 3c")
    @pokerhand = Holdem::PokerRank.new(cards)

    assert_equal :three_kind, @pokerhand.rank
    assert @pokerhand.key_cards.all? {|c| c.rank_value == 3 }
    assert_equal "3h 3s 3c As Kd", @pokerhand.hand_as_string
    assert_equal 4, @pokerhand.score
  end

  # straight

  def test_detect_straight
    cards = build_hand("3h 4c 4d 7h 5s 6d")
    @pokerhand = Holdem::PokerRank.new(cards)

    assert_equal :straight, @pokerhand.rank
    assert_equal "3h 4c 5s 6d 7h", @pokerhand.hand_as_string
  end

  def test_straight_uses_higher_straight_when_two_straights_exist
    cards = build_hand("3h 4c 7h 5s 6d 2c")
    @pokerhand = Holdem::PokerRank.new(cards)

    assert_equal :straight, @pokerhand.rank
    assert_equal "3h 4c 5s 6d 7h", @pokerhand.hand_as_string
  end

  def test_detect_wheel_straight
    cards = build_hand("3h 4c Ah 5s Kd 2c")
    @pokerhand = Holdem::PokerRank.new(cards)

    assert_equal :straight, @pokerhand.rank
    assert_equal "Ah 2c 3h 4c 5s", @pokerhand.hand_as_string
  end

  def test_straight_picks_higher_straight_over_wheel
    cards = build_hand("3h 4c Ah 5s 6d 2c")
    @pokerhand = Holdem::PokerRank.new(cards)

    assert_equal :straight, @pokerhand.rank
    assert_equal "2c 3h 4c 5s 6d", @pokerhand.hand_as_string
  end

  private

  def build_hand(hand_string)
    hand_string.split(" ").map do |card|
      Holdem::Card.new(card)
    end
  end

end

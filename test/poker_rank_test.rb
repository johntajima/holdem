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
    assert_equal "Kd Jc 8s 6d 4h", @pokerhand.hand.map(&:to_s).join(" ")    
  end

  def test_detect_a_pair
    cards = build_hand("As Kd 4h 3h Ks 6d Jc")
    @pokerhand = Holdem::PokerRank.new(cards)

    assert_equal :pair, @pokerhand.rank
    assert_equal "Kd Ks", @pokerhand.key_cards.map(&:to_s).join(" ")
    assert_equal 2, @pokerhand.score
  end

  def test_detect_three_of_a_kind
    cards = build_hand("As Kd 4h 3h 3s 6d 3c")
    @pokerhand = Holdem::PokerRank.new(cards)

    assert_equal :three_kind, @pokerhand.rank
    assert @pokerhand.key_cards.all? {|c| c.rank_value == 3 }
    assert_equal "3h 3s 3c As Kd", @pokerhand.hand.map(&:to_s).join(" ")
  end


  private

  def build_hand(hand_string)
    hand_string.split(" ").map do |card|
      Holdem::Card.new(card)
    end
  end

end

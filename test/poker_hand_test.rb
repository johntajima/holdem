require "test_helper"

class PokerHandTest < Minitest::Test

  def setup

  end


  def test_detect_high_card
    @pokerhand = build_hand("2s Kd 4h 3h 8s 6d Jc")
    
    assert_equal :high_card, @pokerhand.rank
    assert_equal 1, @pokerhand.score
    assert_equal "Kd", @pokerhand.key_cards.map(&:to_s).join(" ")
    assert_equal "Kd Jc 8s 6d 4h", @pokerhand.hand_as_string
  end

  def test_detect_high_card_with_ace
    @pokerhand = build_hand("2s Kd Ah 3h 8s 6d Jc")
    
    assert_equal :high_card, @pokerhand.rank
    assert_equal 1, @pokerhand.score
    assert_equal "Ah", @pokerhand.key_cards.map(&:to_s).join(" ")
    assert_equal "Ah Kd Jc 8s 6d", @pokerhand.hand_as_string
  end

  # pair

  def test_detect_a_pair
    @pokerhand = build_hand("As Kd 4h 3h Ks 6d Jc")

    assert_equal :pair, @pokerhand.rank
    assert_equal "Kd Ks", @pokerhand.key_cards.map(&:to_s).join(" ")
    assert_equal 2, @pokerhand.score
  end


  # two pair

  def test_detect_two_pair
    @pokerhand = build_hand("4h 3h 3s 6d 6c Th Qs")

    assert_equal :two_pair, @pokerhand.rank
    assert_equal "6d 6c 3h 3s Qs", @pokerhand.hand_as_string
    assert_equal 3, @pokerhand.score
  end

  def test_detect_two_pair_picks_highest_two_pair_and_right_kicker
    @pokerhand = build_hand("Ah 3h 3s 6d 6c Th Ts")

    assert_equal :two_pair, @pokerhand.rank
    assert_equal "Th Ts 6d 6c Ah", @pokerhand.hand_as_string
    assert_equal 3, @pokerhand.score
  end


  # three_kind

  def test_detect_three_of_a_kind
    @pokerhand = build_hand("As Kd 4h 3h 3s 6d 3c")

    assert_equal :three_kind, @pokerhand.rank
    assert @pokerhand.key_cards.all? {|c| c.rank_value == 3 }
    assert_equal "3h 3s 3c As Kd", @pokerhand.hand_as_string
    assert_equal 4, @pokerhand.score
  end

  # straight

  def test_detect_straight
    @pokerhand = build_hand("3h 4c 4d 7h 5s 6d Td")

    assert_equal :straight, @pokerhand.rank
    assert_equal "3h 4c 5s 6d 7h", @pokerhand.hand_as_string
  end

  def test_straight_uses_higher_straight_when_two_straights_exist
    @pokerhand = build_hand("3h 4c 7h 5s 6d 2c Jd")

    assert_equal :straight, @pokerhand.rank
    assert_equal "3h 4c 5s 6d 7h", @pokerhand.hand_as_string
  end

  def test_detect_wheel_straight
    @pokerhand = build_hand("3h 4c Ah 5s Kd 2c Jd")

    assert_equal :straight, @pokerhand.rank
    assert_equal "Ah 2c 3h 4c 5s", @pokerhand.hand_as_string
  end

  def test_straight_picks_higher_straight_over_wheel
    @pokerhand = build_hand("3h 4c Ah 5s 6d 2c Jd")

    assert_equal :straight, @pokerhand.rank
    assert_equal "2c 3h 4c 5s 6d", @pokerhand.hand_as_string
  end

  # flush
  def test_detect_flush
    @pokerhand = build_hand("3h 4h 7h 5h Qs 2c Jh")

    assert_equal :flush, @pokerhand.rank
    assert_equal "Jh 7h 5h 4h 3h", @pokerhand.hand_as_string
  end

  def test_flush_picks_higher_flush
    @pokerhand = build_hand("3h 4h 7h 5h Ah 2c Jh")

    assert_equal :flush, @pokerhand.rank
    assert_equal "Ah Jh 7h 5h 4h", @pokerhand.hand_as_string
  end

  # full house

  def test_detect_full_house
    @pokerhand = build_hand("Jh Jd Js Kh Ac Qh Kc")
    assert_equal :full_house, @pokerhand.rank
    assert_equal "Jh Jd Js Kh Kc", @pokerhand.hand_as_string
  end

  def test_select_bigger_full_house_with_two_sets
    @pokerhand = build_hand("Jh Jd Js Kh Ac Kd Kc")
    assert_equal :full_house, @pokerhand.rank
    assert_equal "Kh Kd Kc Jh Jd", @pokerhand.hand_as_string
  end

  def test_select_bigger_full_house_with_two_pairs
    @pokerhand = build_hand("Jh Jd Js Kh Ac Kd As")
    assert_equal :full_house, @pokerhand.rank
    assert_equal "Jh Jd Js Ac As", @pokerhand.hand_as_string
  end


  # Four of a kind

  def test_detect_four_kind
    @pokerhand = build_hand("Jh Jd Js Kh Jc Ah 7c")

    assert_equal :four_kind, @pokerhand.rank
    assert_equal "Jh Jd Js Jc Ah", @pokerhand.hand_as_string
  end

  # straight flush

  def test_detect_straight_flush
    @pokerhand = build_hand("6h 2h 3h 4h 5h 8d 7c")

    assert_equal :straight_flush, @pokerhand.rank
    assert_equal "2h 3h 4h 5h 6h", @pokerhand.hand_as_string    
  end

  def test_straight_flush_pick_higher_straight_flush
    @pokerhand = build_hand("6h 2h 3h 4h 5h 8d 7h")

    assert_equal :straight_flush, @pokerhand.rank
    assert_equal "3h 4h 5h 6h 7h", @pokerhand.hand_as_string
  end
  

  # royal flush

  def test_detect_royal_flush
    @pokerhand = build_hand("4c 3c Ah Kh Jh Qh Th")

    assert_equal :royal_flush, @pokerhand.rank
    assert_equal "Th Jh Qh Kh Ah", @pokerhand.hand_as_string    
  end



  private

  def build_hand(hand_string)
    cards = hand_string.split(" ").map do |card|
      Holdem::Card.new(card)
    end
    Holdem::PokerHand.new(cards)
  end

end

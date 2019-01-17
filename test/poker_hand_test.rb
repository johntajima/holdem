require "test_helper"

class PokerHandTest < Minitest::Test

  def setup

  end


  # def test_id
  #   @pokerhand = build_hand("2s Kd 4h 3h 8s 6d Jc")
  #   assert_equal "2s Kd", @pokerhand.id
  # end

  def test_detect_high_card
    @pokerhand = build_hand("2s Kd 4h 3h 8s 6d Jc")
    assert_equal "High Card", @pokerhand.category
  end

  # def test_detect_high_card_with_ace
  #   @pokerhand = build_hand("2s Kd Ah 3h 8s 6d Jc")
    
  #   assert_equal :high_card, @pokerhand.rank
  #   assert_equal 1, @pokerhand.score
  #   assert_equal "Ah", @pokerhand.key_cards.map(&:to_s).join(" ")
  #   assert_equal "Ah Kd Jc 8s 6d", @pokerhand.hand_as_string
  # end

  # # pair

  # def test_detect_a_pair
  #   @pokerhand = build_hand("As Kd 4h 3h Ks 6d Jc")

  #   assert_equal :pair, @pokerhand.rank
  #   assert_equal "Kd Ks", @pokerhand.key_cards.map(&:to_s).join(" ")
  #   assert_equal 2, @pokerhand.score
  # end


  # # two pair

  # def test_detect_two_pair
  #   @pokerhand = build_hand("4h 3h 3s 6d 6c Th Qs")

  #   assert_equal :two_pair, @pokerhand.rank
  #   assert_equal "6d 6c 3h 3s Qs", @pokerhand.hand_as_string
  #   assert_equal 3, @pokerhand.score
  # end

  # def test_detect_two_pair_picks_highest_two_pair_and_right_kicker
  #   @pokerhand = build_hand("Ah 3h 3s 6d 6c Th Ts")

  #   assert_equal :two_pair, @pokerhand.rank
  #   assert_equal "Th Ts 6d 6c Ah", @pokerhand.hand_as_string
  #   assert_equal 3, @pokerhand.score
  # end


  # # three_kind

  # def test_detect_three_of_a_kind
  #   @pokerhand = build_hand("As Kd 4h 3h 3s 6d 3c")

  #   assert_equal :three_kind, @pokerhand.rank
  #   assert @pokerhand.key_cards.all? {|c| c.rank_value == 3 }
  #   assert_equal "3h 3s 3c As Kd", @pokerhand.hand_as_string
  #   assert_equal 4, @pokerhand.score
  # end

  # # straight

  # def test_detect_straight
  #   @pokerhand = build_hand("3h 4c 4d 7h 5s 6d Td")

  #   assert_equal :straight, @pokerhand.rank
  #   assert_equal "3h 4c 5s 6d 7h", @pokerhand.hand_as_string
  # end

  # def test_straight_uses_higher_straight_when_two_straights_exist
  #   @pokerhand = build_hand("3h 4c 7h 5s 6d 2c Jd")

  #   assert_equal :straight, @pokerhand.rank
  #   assert_equal "3h 4c 5s 6d 7h", @pokerhand.hand_as_string
  # end

  # def test_detect_wheel_straight
  #   @pokerhand = build_hand("3h 4c Ah 5s Kd 2c Jd")

  #   assert_equal :wheel_straight, @pokerhand.rank
  #   assert_equal "Ah 2c 3h 4c 5s", @pokerhand.hand_as_string    
  # end

  # def test_straight_picks_higher_straight_over_wheel
  #   @pokerhand = build_hand("3h 4c Ah 5s 6d 2c Jd")

  #   assert_equal :straight, @pokerhand.rank
  #   assert_equal "2c 3h 4c 5s 6d", @pokerhand.hand_as_string
  # end

  # # flush
  # def test_detect_flush
  #   @pokerhand = build_hand("3h 4h 7h 5h Qs 2c Jh")

  #   assert_equal :flush, @pokerhand.rank
  #   assert_equal "Jh 7h 5h 4h 3h", @pokerhand.hand_as_string
  # end

  # def test_flush_picks_higher_flush
  #   @pokerhand = build_hand("3h 4h 7h 5h Ah 2c Jh")

  #   assert_equal :flush, @pokerhand.rank
  #   assert_equal "Ah Jh 7h 5h 4h", @pokerhand.hand_as_string
  # end

  # # full house

  # def test_detect_full_house
  #   @pokerhand = build_hand("Jh Jd Js Kh Ac Qh Kc")
  #   assert_equal :full_house, @pokerhand.rank
  #   assert_equal "Jh Jd Js Kh Kc", @pokerhand.hand_as_string
  # end

  # def test_select_bigger_full_house_with_two_sets
  #   @pokerhand = build_hand("Jh Jd Js Kh Ac Kd Kc")
  #   assert_equal :full_house, @pokerhand.rank
  #   assert_equal "Kh Kd Kc Jh Jd", @pokerhand.hand_as_string
  # end

  # def test_select_bigger_full_house_with_two_pairs
  #   @pokerhand = build_hand("Jh Jd Js Kh Ac Kd As")
  #   assert_equal :full_house, @pokerhand.rank
  #   assert_equal "Jh Jd Js Ac As", @pokerhand.hand_as_string
  # end


  # # Four of a kind

  # def test_detect_four_kind
  #   @pokerhand = build_hand("Jh Jd Js Kh Jc Ah 7c")

  #   assert_equal :four_kind, @pokerhand.rank
  #   assert_equal "Jh Jd Js Jc Ah", @pokerhand.hand_as_string
  # end

  # # straight flush

  # def test_detect_straight_flush
  #   @pokerhand = build_hand("6h 2h 3h 4h 5h 8d 7c")

  #   assert_equal :straight_flush, @pokerhand.rank
  #   assert_equal "2h 3h 4h 5h 6h", @pokerhand.hand_as_string    
  # end

  # def test_straight_flush_pick_higher_straight_flush
  #   @pokerhand = build_hand("6h 2h 3h 4h 5h 8d 7h")

  #   assert_equal :straight_flush, @pokerhand.rank
  #   assert_equal "3h 4h 5h 6h 7h", @pokerhand.hand_as_string
  # end

  # def test_straight_flush_wheel
  #   @pokerhand = build_hand("2h 3h 4h 5h 8d Ah 7c")

  #   assert_equal :wheel_straight_flush, @pokerhand.rank
  #   assert_equal "Ah 2h 3h 4h 5h", @pokerhand.hand_as_string
  # end
  

  # # royal flush

  # def test_detect_royal_flush
  #   @pokerhand = build_hand("4c 3c Ah Kh Jh Qh Th")

  #   assert_equal :royal_flush, @pokerhand.rank
  #   assert_equal "Th Jh Qh Kh Ah", @pokerhand.hand_as_string    
  # end


  # # kickers

  # def test_high_card_kicker_values_in_descending_order
  #   @pokerhand = build_hand("2s Kd 4h 3h 8s 6d Jc")    
  #   assert_equal [13, 11, 8, 6, 4], @pokerhand.kickers
  # end

  # def test_pair_kicker_values_have_pairs_first_then_kickers
  #   @pokerhand = build_hand("As Kd 4h 3h Ks 6d Jc")
  #   assert_equal [13, 13, 14, 11, 6], @pokerhand.kickers
  # end

  # def test_two_pair_kicker_values_have_pairs_first_then_kicker
  #   @pokerhand = build_hand("4h 3h 3s 6d 6c Th Qs")
  #   assert_equal [6, 6, 3, 3, 12], @pokerhand.kickers
  # end

  # def test_three_kind_kickers
  #   @pokerhand = build_hand("As Kd 4h 3h 3s 6d 3c")
  #   assert_equal [3, 3, 3, 14, 13], @pokerhand.kickers
  # end

  # def test_wheel_straight_kicker
  #   @pokerhand = build_hand("3h 4c Ah 5s Kd 2c Jd")
  #   assert_equal [5, 4, 3, 2, 1], @pokerhand.kickers
  # end

  # def test_straight_kicker
  #   @pokerhand = build_hand("3h 4c 4d 7h 5s 6d Td")
  #   assert_equal [7,6,5,4,3], @pokerhand.kickers
  # end

  # def test_flush_kicker
  #   @pokerhand = build_hand("3h 4h 7h 5h Qs 2c Jh")
  #   assert_equal [11, 7, 5, 4, 3], @pokerhand.kickers
  # end

  # def test_full_house_kicker
  #   @pokerhand = build_hand("Jh Jd Js Kh Ac Qh Kc")
  #   assert_equal [11, 11, 11, 13, 13], @pokerhand.kickers
  # end

  # def test_four_kind_kicker
  #   @pokerhand = build_hand("Jh Jd Js Kh Jc Ah 7c")
  #   assert_equal [11, 11, 11, 11, 14], @pokerhand.kickers
  # end

  # def test_straight_flush_kicker
  # end

  # def test_wheel_straight_flush_kicker
  # end

  # def test_royal_flush_kicker
  # end


  # # better_than? - high hand

  # def test_better_hand_vs_worse_hand
  #   @flush = build_hand("6h 2h 3h 4h 5h 8d 7c")
  #   @high = build_hand("2s Kd 4h 3h 8s 6d Jc")

  #   assert_equal 1, @flush.better_than?(@high)
  # end

  # def test_high_card_vs_high_card_with_better_mid_card
  #   @hand1 = build_hand("2s Kd 4h 3h 8s 6d Jc")
  #   @hand2 = build_hand("2s Kh 4h 3h 9s 6d Jc")
  #   assert_equal 1, @hand2.better_than?(@hand1)
  # end

  # def test_high_hand_vs_pair
  # end

  # def test_high_hand_vs_two_pair
  # end

  # def test_high_hand_vs_set
  # end

  # def test_high_hand_vs_straight
  # end

  # def test_high_hand_vs_flush
  # end

  # def test_high_hand_vs_full_house
  # end

  # def test_high_hand_vs_straight_flush
  # end

  # def test_high_hand_vs_royal_flush
  # end


  # # better_than? - pair

  # def test_pair_vs_high_card
  #   @pair = build_hand("As Kd 4h 3h Ks 6d Jc")
  #   @hand1 = build_hand("2s Kd 4h 3h 8s 6d Jc")
  #   assert_equal 1, @pair.better_than?(@hand1)
  # end

  # def test_pair_vs_worse_pair
  #   @pair1 = build_hand("As Kd 4h 3h Ks 6d Jc")
  #   @pair2 = build_hand("As Kd 4h Ah Ks 6d Jc")
  #   assert_equal 1, @pair2.better_than?(@pair1)
  # end


  # # better_than? - two pair
  
  # # better_than? - three

  # # better_than? - straight

  # # better_than? - wheel straight

  # # better_than? - flush

  # # better_than? - full house

  # # better_than? - straight flush

  # # better_than? - wheel straight flush

  # # better_than? - royal flush

  # def test_royal_flush_vs_any
  # end


  # # better_than? - ties
  
  # def test_same_hand_scores
  #   @hand1 = build_hand("2s Kd 4h 3h 8s 6d Jc")
  #   @hand2 = build_hand("2s Kh 4h 3h 8s 6d Jc")
  #   assert_equal 0, @hand1.better_than?(@hand2)
  #   assert_equal 0, @hand2.better_than?(@hand1)
  # end

  # def test_worse_hand_vs_better_hand
  #   @flush = build_hand("6h 2h 3h 4h 5h 8d 7c")
  #   @acehigh = build_hand("2s Kd 4h 3h 8s 6d Jc")

  #   assert_equal (-1), @acehigh.better_than?(@flush)
  #   assert_equal 1, @flush.better_than?(@acehigh)
  # end

end

require "test_helper"

class PokerHandTest < Minitest::Test

  def setup
  end


  def test_detect_high_card
    @pokerhand = build_hand("2s Kd 4h 3h 8s 6d Jc")
    assert_equal :high_card, @pokerhand.category
  end

  def test_high_card_with_better_high_card_has_higher_score
    @h1 = build_hand("2s Kd 4h 3h 8s 6d Jc")
    @h2 = build_hand("2s Ad 4h 3h 8s 6d Jc")
    assert_equal :high_card, @h1.category
    assert_equal :high_card, @h2.category
    assert @h2.rank > @h1.rank
  end

  def test_two_hands_with_same_ranks_have_same_score
    @h1 = build_hand("2s Kd 4h 3h 8s 6d Jc")
    @h2 = build_hand("2s Kh 4h 3h 8s 6d Jc")
    assert_equal :high_card, @h1.category
    assert_equal :high_card, @h2.category
    assert_equal @h2.rank, @h1.rank
  end
  

  def test_detect_a_pair
    @pokerhand = build_hand("As Kd 4h 3h Ks 6d Jc")
    assert_equal :pair, @pokerhand.category
  end

  def test_better_pair_has_higher_rank
    @h1 = build_hand("Ah Ac 2c 3c 4c Td Jd")
    @h2 = build_hand("Qh Qc 2c 3c 4c Td Jd")
    assert_equal :pair, @h1.category
    assert_equal :pair, @h1.category
    assert @h1.rank, @h2.rank
  end

  def test_detect_two_pair
    @pokerhand = build_hand("4h 3h 3s 6d 6c Th Qs")
    assert_equal :two_pair, @pokerhand.category
  end

  # tests that show certain hands have better ranking than others
  # tests that test same hands w better kickers

  def test_royal_flush_has_better_ranking_than_straight_flush
    @h1 = build_hand("Ah Kh Qh Jh Th 4c 3h")
    @h2 = build_hand("Ac 2h 3h 4h 5h 6h 9d")
    assert @h1.rank > @h2.rank
  end

end

require "test_helper"

class CardTest < Minitest::Test

  def test_new_card_with_string
    @card = Holdem::Card.new("As")
    assert_equal "As", @card.to_s
    assert_equal 51,  @card.id
    assert_equal 's',  @card.suit
    assert_equal 'A',  @card.rank
  end

  def test_new_card_from_card
    @card = Holdem::Card.new("As")
    @card2 = Holdem::Card.new(@card)
    assert_equal @card, @card2
  end

  def test_two_cards_are_the_same_if_they_are_same_rank_and_suit
    @card = Holdem::Card.new("As")
    @card2 = Holdem::Card.new("As")
    assert_equal @card, @card2
    assert_equal @card.id, @card2.id
  end

  # rank_value
  def test_rank_value_of_card
    a = Holdem::Card.new('As')
    b = Holdem::Card.new('4h');
    c =  Holdem::Card.new('Kh');
    d = Holdem::Card.new('Js')
    new_order = [a,b,c,d].sort {|a,b| b.rank_value <=> a.rank_value }
    assert_equal [a, c, d, b], new_order
  end

  # wheel_rank_value
  def test_ace_value_is_1_for_wheel_rank_value
    a = Holdem::Card.new('As')
    assert_equal 1, a.wheel_rank_value    
  end

  # test validate syntax (Ten, no other chars, upper/lower case, etc.)
end

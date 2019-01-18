$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "holdem"
require "minitest/autorun"


def build_hand(cards_string)
  cards = build_cards(cards_string)
  Holdem::PokerHand.new(cards)
end

def build_cards(cards_string)
  cards_string.split(" ").map do |card|
    Holdem::Card.new(card)
  end
end


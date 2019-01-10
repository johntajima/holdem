require "holdem/version"
require "holdem/errors"
require "holdem/card"
require "holdem/deck"
require 'holdem/board'
require 'holdem/hand'
require 'holdem/simulation'
require 'holdem/poker_rank'

# card index 0-12 clubs, 13-25 hearts, 26-38 diamonds, 39-51 spades

module Holdem
  SUITS      = %w|c h d s|
  RANKS      = %w|2 3 4 5 6 7 8 9 T J Q K A|
  SUIT_COUNT = 13
  ACE        = 14
  KING       = 13
  QUEEN      = 12
  JACK       = 11
end

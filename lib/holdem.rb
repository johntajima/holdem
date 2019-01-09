require "holdem/version"
require "holdem/errors"
require "holdem/card"
require "holdem/deck"


# card index 0-12 clubs, 13-x hearts, ..., ...

module Holdem
  SUITS      = %w|c h d s|
  RANKS      = %w|2 3 4 5 6 7 8 9 T J Q K A|
  SUIT_COUNT = 13


end

require 'hand_rank'
require "holdem/version"
require "holdem/errors"
require "holdem/card"
require "holdem/deck"
require 'holdem/poker_hand'
require 'holdem/simulation'

module Holdem
  CARD_VALUE_LOOKUP = {
    #       spacer,  A,  2,  3,  4,  5,  6,  7,  8,  9, 10,  J,  Q,  K,  A
      "c" => [ nil, 49,  1,  5,  9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49 ],
      "d" => [ nil, 50,  2,  6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50 ],
      "h" => [ nil, 51,  3,  7, 11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51 ],
      "s" => [ nil, 52,  4,  8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52 ],
  }
end

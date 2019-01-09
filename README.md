# Holdem

Ruby gem for NL Holdem. 

Given players' hole cards and board, will calculate via Monte Carlo simulation probabilities.
[more]


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'holdem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install holdem

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/holdem.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


# HLD


### models

Deck (randomized deck of 52 cards)
- 52 Cards

Card
- rank, suit

Board
  - flop
  - turn
  - river

Player
- has hole cards
- has bet amount
- has remaining stack amount
- given board, should calculate what type of hand they have

Hand
model of one hand 
- 1-9 possible players
- each player has hole cards
- each player has possible bet amount
- pot amount
- board of existing cards (flop, turn, river)
- should calculate precentage of win/lose/chop for each player


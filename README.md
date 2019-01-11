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

Run calculations to determine % win based on hands and board using a Monte Carlo simulation

> sim = Holdem::Simulation.new([card_string, card_string,...], board)
> sim.run(trials) #=> run trials and returns hash of results

  {
    trials_run: 10000,
    board: "As Jc Td",
    players: [
      {
        cards: "As Ac",
        win: 0.58293,
        tie: 0.00023
      },
      {
        cards: "Jc Qc",
        win: 0.21293,
        tie: 0.00023      
      },
      ...
  }





## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/holdem.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


# HLD

  # Hand model calculate percentages only based on # of runs
  # always assume first player/hole cards is Hero

  hand = Holdem::Hand.new(cards, board, options: )

  # cards = [ [player1 cards], [player 2 cards], ...]
  # board = ['As', '2c', '4d', .., ..]  # flop, turn, river
  # options
  # - trials: 10000 (default) 100-1_000_000

  #
  # Run simulation
  #
  response = hand.calculate!
  {
    players: [
      {
        cards: [xx, xx],
        win: 0.123,
        tie: 0.002
      },
      {
        cards: [xx,xx],
        win: 0.4812,
        tie: 0.002,
      },
      ...
    ],
    board: [ 'xx', 'xx', 'xx', 'xx'],
    trials: 10_000,
    time: (in ms)
  }



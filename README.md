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

Output:

    {
      trials: 10000,
      board: "As Jc Td",
      hands: [
        "As Ac" : {
          win: 1230,
          tie: 10,
          win_pct: 89.39,
          tie_pct: 1.23

        },
        "Jc Qc" : {
          win: 103,
          tie: 10,
          win_pct: 3.39,
          tie_pct: 1.23
        }
      ],
      duration: 3.2934
    }





## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/holdem.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


# HLD




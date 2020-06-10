# percentage

![Gem Version](https://badge.fury.io/rb/percentage.svg)
![Build Status](https://github.com/readysteady/percentage/workflows/Test/badge.svg)


Ruby gem for working with percentages.


## Installation

    $ gem install percentage


## Constructing Percentages

The `Percentage` method converts numeric objects to percentage objects
with values that you would expect:

```ruby
Percentage(50)  # => 50%

Percentage(BigDecimal('17.5'))  # => 17.5%

Percentage(Rational(25, 2))  # => 12.5%
```

Percentage objects can also be constructed directly, but in this case
BigDecimal/Rational values are treated as fractions:

```ruby
Percentage.new(50)  # => 50%

Percentage.new(BigDecimal('0.175'))  # => 17.5%

Percentage.new(Rational(1, 8))  # => 12.5%
```

Some shortcut methods are defined on Integer and BigDecimal for convenience:

```ruby
50.percent  # => 50%

5.as_percentage_of(10)  # => 50.0%

BigDecimal('2.9').to_percentage  # => 2.9%
```


## Numeric features

As with other numerics, percentage objects are conceptually immutable.
Common numeric functionality like `to_i`, `to_f`, `to_s`, `to_r`, `zero?`,
and equality/comparison methods are defined.

Percentages can be added together:

```ruby
Percentage(10) + Percentage(20)  # => 30%
```

They can also be "scaled up" using the `scale` method:

```ruby
Percentage(10).scale(5)  # => 50%
```

Multiplication is defined using the fractional value of the percentage.
BigDecimal objects can't be coerced into rational objects, so the
multiplication order will matter in some cases, for example:

```ruby
Percentage(50) * 10  # => (5/1)

Percentage(50) * Percentage(10)  # => 5.0%

BigDecimal('150.00') * Percentage(50)  # => BigDecimal('75.00')

Percentage(50) * BigDecimal('150.00')  # raises TypeError
```


## Bonus extras

There's a #percent_of method defined on Integer and BigDecimal for percentage calculations:

```ruby
50.percent_of(BigDecimal(150))  # => BigDecimal('75.00')

10.percent_of(100)  # => (10/1)

BigDecimal('0.5').percent_of(88)  # => BigDecimal('0.44')
```

There's also a `Percentage.change` method for calculating the percentage change between two values:

```ruby
Percentage.change(2, 3)  # => 50.0%
```

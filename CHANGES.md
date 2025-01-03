# 2.3.0

* **Required ruby version is now 2.5.0**

* Added Percentage#nonzero?

* Added Percentage#inspect

# 2.2.0

* Added Rational#to_percentage

* Added Rational#percent_of

* Added Rational#as_percentage_of

# 2.1.1

* Added bigdecimal gem dependency (thanks @orien)

# 2.1.0

* Added Percentage#-@

* Added Percentage#positive?

* Added Percentage#negative?

# 2.0.0

* Added Percentage#to_d

* Percentage instances are now frozen on initialization

* Changed `Percentage.change` to return `nil` when first argument is zero

# 1.4.1

* Added CHANGES.md to gem files

* Fixed outdated changelog_uri

# 1.4.0

* Added optional YAML integration

This makes it possible to dump/load percentage objects to/from YAML as scalar values. For example:

    require 'percentage/yaml'

    puts YAML.dump([Percentage(BigDecimal('17.5'))])

This functionality is not enabled by default, due to the use of Module#prepend.

# 1.3.0

* Added ndigits argument to Percentage#truncate

# 1.2.0

* Removed memoization so that Percentage objects can be frozen (thanks @iamvery)

# 1.1.0

* Added BigDecimal#to_percentage and Integer#to_percentage

* Added BigDecimal#percent_of (thanks @mikeymicrophone)

# 1.0.0

* First version!

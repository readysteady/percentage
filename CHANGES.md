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

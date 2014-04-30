# Poltergeist::Suppressor

A noisy warnings suppressor for capybara/poltergeist.

This gem silences noisy phantomjs warnings such as 'CoreText performance note...'.

Example before using:

```
% rspec ./spec/example_spec.rb
2014-05-01 05:26:27.380 phantomjs[92529:507] *** WARNING: Method userSpaceScaleFactor in class NSView is deprecated on 10.7 and later. It should not be used in new applications. Use convertRectToBacking: instead.
2014-05-01 05:26:27.927 phantomjs[92529:507] CoreText performance note: Client called CTFontCreateWithName() using name "Helvetica Neue" and got font with PostScript name "HelveticaNeue". For best performance, only use PostScript names when calling this API.
2014-05-01 05:26:27.927 phantomjs[92529:507] CoreText performance note: Set a breakpoint on CTFontLogSuboptimalRequest to debug.
2014-05-01 05:26:27.931 phantomjs[92529:507] CoreText performance note: Client called CTFontCreateWithName() using name "Lucida Grande" and got font with PostScript name "LucidaGrande". For best performance, only use PostScript names when calling this API.
2014-05-01 05:26:27.932 phantomjs[92529:507] CoreText performance note: Client called CTFontCreateWithName() using name "Lucida Grande" and got font with PostScript name "LucidaGrande". For best performance, only use PostScript names when calling this API.
2014-05-01 05:26:27.934 phantomjs[92529:507] CoreText performance note: Client called CTFontCreateWithName() using name "Lucida Grande" and got font with PostScript name "LucidaGrande". For best performance, only use PostScript names when calling this API.
2014-05-01 05:26:27.934 phantomjs[92529:507] CoreText performance note: Client called CTFontCreateWithName() using name "Lucida Grande" and got font with PostScript name "LucidaGrande". For best performance, only use PostScript names when calling this API.
2014-05-01 05:26:27.935 phantomjs[92529:507] CoreText performance note: Client called CTFontCreateWithName() using name "Lucida Grande" and got font with PostScript name "LucidaGrande". For best performance, only use PostScript names when calling this API.
2014-05-01 05:26:28.184 phantomjs[92529:507] CoreText performance note: Client called CTFontCreateWithName() using name "Lucida Grande" and got font with PostScript name "LucidaGrande". For best performance, only use PostScript names when calling this API.
2014-05-01 05:26:28.184 phantomjs[92529:507] CoreText performance note: Client called CTFontCreateWithName() using name "Lucida Grande" and got font with PostScript name "LucidaGrande". For best performance, only use PostScript names when calling this API.
2014-05-01 05:26:28.184 phantomjs[92529:507] CoreText performance note: Client called CTFontCreateWithName() using name "Lucida Grande" and got font with PostScript name "LucidaGrande". For best performance, only use PostScript names when calling this API.
2014-05-01 05:26:28.470 phantomjs[92529:507] CoreText performance note: Client called CTFontCreateWithName() using name "Helvetica Neue" and got font with PostScript name "HelveticaNeue". For best performance, only use PostScript names when calling this API.
.

Finished in 3.7 seconds
1 example, 0 failures

```


Use poltergeist-suppressor:

```
% rspec ./spec/example_spec.rb
.

Finished in 3.7 seconds
1 example, 0 failures

```


## Installation

Add this line to your application's Gemfile:

    gem 'poltergeist-suppressor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install poltergeist-suppressor

## Usage

Add these lines to spec_helper.rb:
``` ruby
require 'capybara/poltergeist'
require 'poltergeist/suppressor'
```

This gem automatically set a suppressed driver to `:poltergeist`.

You can manually add a suppressor to your driver.
``` ruby
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
    phantomjs_logger: Capybara::Poltergeist::Suppressor.new
  )
end
```

And you can specify ignore patterns in regexp.

``` ruby
suppressor = Capybara::Poltergeist::Suppressor.new(patterns: [
  /spam spam spam spam/,
  /spamspamspamspam/
])

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs_logger: suppressor)
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

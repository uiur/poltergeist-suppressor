require 'capybara/poltergeist'
require "poltergeist/suppressor/version"
require "poltergeist/suppressor/redirect_stderr"

module Capybara::Poltergeist
  class Suppressor
    DEFAULT_PATTERNS = [
      /QFont::setPixelSize: Pixel size <= 0/,
      /CoreText performance note:/,
      /WARNING: Method userSpaceScaleFactor/
    ]

    def initialize(args = {})
      @patterns = args[:patterns] || DEFAULT_PATTERNS
    end

    def write(message)
      if ignore_message?(message)
        0
      else
        puts(message)
        1
      end
    end

    private
    def ignore_message?(message)
      @patterns.any? {|regexp| message =~ regexp }
    end
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app,
    phantomjs_logger: Capybara::Poltergeist::Suppressor.new
  )
end

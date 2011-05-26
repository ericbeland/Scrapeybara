# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scrapeybara/version"

Gem::Specification.new do |s|
  s.name        = "scrapeybara"
  s.version     = Scrapeybara::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Eric Beland"]
  s.email       = ["ebeland@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A Capybara based web scraping tool}
  s.description = %q{Scrapybara provides a DSL and various facilities for extracting page data via Capybara}
  
  s.add_dependency "capybara"
  s.add_dependency "hashie"


  s.rubyforge_project = "scrapeybara"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

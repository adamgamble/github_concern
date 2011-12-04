$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "github_concern/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "github_concern"
  s.version     = GithubConcern::VERSION
  s.authors     = ["Adam Gamble"]
  s.email       = ["adamgamble@gmail.com"]
  s.homepage    = "http://www.github.com/adamgamble/github_concern"
  s.summary     = "Easily associate git commits with models"
  s.description = "Easily associate git commits with models"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.3"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end

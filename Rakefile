begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rails3_assist"
    gem.summary = %Q{File operation helpers for Rails 3 artifacts}
    gem.description = %Q{Basic file operation helpers for working with Rails 3 artifacts}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/rails3-assist"
    gem.authors = ["Kristian Mandrup"]
    gem.add_development_dependency "rspec",           ">= 2.0.0"
    gem.add_development_dependency 'rails-app-spec',  '~> 0.3.0'

    gem.add_dependency "require_all",       "~> 1.2.0"
    gem.add_dependency "sugar-high",        "~> 0.3.0"
    gem.add_dependency "activesupport",     "~> 3.0"
    gem.add_dependency "migration_assist",  "~> 0.1.4"
    gem.add_dependency "thor",              ">= 0.14.0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end


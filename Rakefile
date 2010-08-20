begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rails3_assist"
    gem.summary = %Q{Assist in operating on Rails 3 artifacts including migrations}
    gem.description = %Q{Assist in operating on Rails 3 artifacts including migrations}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/rails3-assist"
    gem.authors = ["Kristian Mandrup"]
    gem.add_development_dependency "rspec", ">= 2.0.0.beta.19"
    gem.add_development_dependency 'rails-app-spec', '>= 0.2.2'

    gem.add_dependency "require_all",       ">= 1.1.0"
    gem.add_dependency "migration_assist", ">= 0.1.2"

    # gem.add_development_dependency "generator-rspec", ">= 0.6.0"

    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end


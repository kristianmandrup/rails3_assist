# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails3_assist}
  s.version = "0.2.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2010-09-17}
  s.description = %q{Assist in operating on Rails 3 artifacts including migrations}
  s.email = %q{kmandrup@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     ".rspec",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "lib/rails3_assist.rb",
     "lib/rails3_assist/app.rb",
     "lib/rails3_assist/artifact.rb",
     "lib/rails3_assist/artifact/directory.rb",
     "lib/rails3_assist/artifact/files.rb",
     "lib/rails3_assist/artifact/path.rb",
     "lib/rails3_assist/directory.rb",
     "lib/rails3_assist/directory/app.rb",
     "lib/rails3_assist/directory/container.rb",
     "lib/rails3_assist/directory/root.rb",
     "lib/rails3_assist/file.rb",
     "lib/rails3_assist/file/application.rb",
     "lib/rails3_assist/file/environment.rb",
     "lib/rails3_assist/file/special.rb",
     "lib/rails3_assist/files.rb",
     "lib/rails3_assist/namespaces.rb",
     "lib/rails3_assist/rspec/configure.rb",
     "rails3_assist.gemspec",
     "rails_generator.log",
     "spec/fixtures.rb",
     "spec/fixtures/.gitignore",
     "spec/fixtures/Gemfile",
     "spec/fixtures/Gemfile.lock",
     "spec/fixtures/README",
     "spec/fixtures/Rakefile",
     "spec/fixtures/app/controllers/application_controller.rb",
     "spec/fixtures/app/controllers/users_controller.rb",
     "spec/fixtures/app/helpers/application_helper.rb",
     "spec/fixtures/app/helpers/users_helper.rb",
     "spec/fixtures/app/mailers/user_mailer.rb",
     "spec/fixtures/app/models/user.rb",
     "spec/fixtures/app/models/user_observer.rb",
     "spec/fixtures/app/permits/user_permit.rb",
     "spec/fixtures/app/views/layouts/application.html.erb",
     "spec/fixtures/app/views/users/_form.html.erb",
     "spec/fixtures/app/views/users/edit.html.erb",
     "spec/fixtures/app/views/users/index.html.erb",
     "spec/fixtures/app/views/users/new.html.erb",
     "spec/fixtures/app/views/users/show.html.erb",
     "spec/fixtures/config.ru",
     "spec/fixtures/config/application.rb",
     "spec/fixtures/config/boot.rb",
     "spec/fixtures/config/database.yml",
     "spec/fixtures/config/environment.rb",
     "spec/fixtures/config/environments/development.rb",
     "spec/fixtures/config/environments/production.rb",
     "spec/fixtures/config/environments/test.rb",
     "spec/fixtures/config/initializers/backtrace_silencers.rb",
     "spec/fixtures/config/initializers/inflections.rb",
     "spec/fixtures/config/initializers/mime_types.rb",
     "spec/fixtures/config/initializers/secret_token.rb",
     "spec/fixtures/config/initializers/session_store.rb",
     "spec/fixtures/config/locales/en.yml",
     "spec/fixtures/config/routes.rb",
     "spec/fixtures/db/migrate/20100831135208_create_users.rb",
     "spec/fixtures/db/seeds.rb",
     "spec/fixtures/doc/README_FOR_APP",
     "spec/fixtures/lib/tasks/.gitkeep",
     "spec/fixtures/log/development.log",
     "spec/fixtures/log/production.log",
     "spec/fixtures/log/server.log",
     "spec/fixtures/log/test.log",
     "spec/fixtures/public/404.html",
     "spec/fixtures/public/422.html",
     "spec/fixtures/public/500.html",
     "spec/fixtures/public/favicon.ico",
     "spec/fixtures/public/images/rails.png",
     "spec/fixtures/public/index.html",
     "spec/fixtures/public/javascripts/application.js",
     "spec/fixtures/public/javascripts/controls.js",
     "spec/fixtures/public/javascripts/dragdrop.js",
     "spec/fixtures/public/javascripts/effects.js",
     "spec/fixtures/public/javascripts/prototype.js",
     "spec/fixtures/public/javascripts/rails.js",
     "spec/fixtures/public/robots.txt",
     "spec/fixtures/public/stylesheets/.gitkeep",
     "spec/fixtures/public/stylesheets/scaffold.css",
     "spec/fixtures/script/rails",
     "spec/fixtures/test/fixtures/users.yml",
     "spec/fixtures/test/functional/users_controller_test.rb",
     "spec/fixtures/test/performance/browsing_test.rb",
     "spec/fixtures/test/test_helper.rb",
     "spec/fixtures/test/unit/helpers/users_helper_test.rb",
     "spec/fixtures/test/unit/user_test.rb",
     "spec/fixtures/vendor/plugins/.gitkeep",
     "spec/load_spec.rb",
     "spec/rails3_assist/app_spec.rb",
     "spec/rails3_assist/artifact/directory_spec.rb",
     "spec/rails3_assist/artifact/files_spec.rb",
     "spec/rails3_assist/artifact/path_spec.rb",
     "spec/rails3_assist/artifact_spec.rb",
     "spec/rails3_assist/directory/app_spec.rb",
     "spec/rails3_assist/directory/container_spec.rb",
     "spec/rails3_assist/directory/root_spec.rb",
     "spec/rails3_assist/directory_spec.rb",
     "spec/rails3_assist/file/application_spec.rb",
     "spec/rails3_assist/file/environment_spec.rb",
     "spec/rails3_assist/file/special_spec.rb",
     "spec/rails3_assist/file_spec.rb",
     "spec/rails3_assist/files_spec.rb",
     "spec/rails3_assist/rspec/have_app_config_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/rails3-assist}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Assist in operating on Rails 3 artifacts including migrations}
  s.test_files = [
    "spec/fixtures/app/controllers/application_controller.rb",
     "spec/fixtures/app/controllers/users_controller.rb",
     "spec/fixtures/app/helpers/application_helper.rb",
     "spec/fixtures/app/helpers/users_helper.rb",
     "spec/fixtures/app/mailers/user_mailer.rb",
     "spec/fixtures/app/models/user.rb",
     "spec/fixtures/app/models/user_observer.rb",
     "spec/fixtures/app/permits/user_permit.rb",
     "spec/fixtures/config/application.rb",
     "spec/fixtures/config/boot.rb",
     "spec/fixtures/config/environment.rb",
     "spec/fixtures/config/environments/development.rb",
     "spec/fixtures/config/environments/production.rb",
     "spec/fixtures/config/environments/test.rb",
     "spec/fixtures/config/initializers/backtrace_silencers.rb",
     "spec/fixtures/config/initializers/inflections.rb",
     "spec/fixtures/config/initializers/mime_types.rb",
     "spec/fixtures/config/initializers/secret_token.rb",
     "spec/fixtures/config/initializers/session_store.rb",
     "spec/fixtures/config/routes.rb",
     "spec/fixtures/db/migrate/20100831135208_create_users.rb",
     "spec/fixtures/db/seeds.rb",
     "spec/fixtures/test/functional/users_controller_test.rb",
     "spec/fixtures/test/performance/browsing_test.rb",
     "spec/fixtures/test/test_helper.rb",
     "spec/fixtures/test/unit/helpers/users_helper_test.rb",
     "spec/fixtures/test/unit/user_test.rb",
     "spec/fixtures.rb",
     "spec/load_spec.rb",
     "spec/rails3_assist/app_spec.rb",
     "spec/rails3_assist/artifact/directory_spec.rb",
     "spec/rails3_assist/artifact/files_spec.rb",
     "spec/rails3_assist/artifact/path_spec.rb",
     "spec/rails3_assist/artifact_spec.rb",
     "spec/rails3_assist/directory/app_spec.rb",
     "spec/rails3_assist/directory/container_spec.rb",
     "spec/rails3_assist/directory/root_spec.rb",
     "spec/rails3_assist/directory_spec.rb",
     "spec/rails3_assist/file/application_spec.rb",
     "spec/rails3_assist/file/environment_spec.rb",
     "spec/rails3_assist/file/special_spec.rb",
     "spec/rails3_assist/file_spec.rb",
     "spec/rails3_assist/files_spec.rb",
     "spec/rails3_assist/rspec/have_app_config_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.0.0.beta.22"])
      s.add_development_dependency(%q<rails-app-spec>, ["~> 0.2.5"])
      s.add_runtime_dependency(%q<require_all>, ["~> 1.1.0"])
      s.add_runtime_dependency(%q<sugar-high>, ["~> 0.2.5"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<migration_assist>, ["~> 0.1.3"])
      s.add_runtime_dependency(%q<thor>, ["~> 0.14.0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.0.0.beta.22"])
      s.add_dependency(%q<rails-app-spec>, ["~> 0.2.5"])
      s.add_dependency(%q<require_all>, ["~> 1.1.0"])
      s.add_dependency(%q<sugar-high>, ["~> 0.2.5"])
      s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
      s.add_dependency(%q<migration_assist>, ["~> 0.1.3"])
      s.add_dependency(%q<thor>, ["~> 0.14.0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.0.0.beta.22"])
    s.add_dependency(%q<rails-app-spec>, ["~> 0.2.5"])
    s.add_dependency(%q<require_all>, ["~> 1.1.0"])
    s.add_dependency(%q<sugar-high>, ["~> 0.2.5"])
    s.add_dependency(%q<activesupport>, ["~> 3.0.0"])
    s.add_dependency(%q<migration_assist>, ["~> 0.1.3"])
    s.add_dependency(%q<thor>, ["~> 0.14.0"])
  end
end


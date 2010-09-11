# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails3_assist}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = %q{2010-09-11}
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
     "lib/rails3_assist/app/file_names.rb",
     "lib/rails3_assist/app/methods/crud.rb",
     "lib/rails3_assist/app/methods/new_content.rb",
     "lib/rails3_assist/app/rails_dirs.rb",
     "lib/rails3_assist/app/rails_files.rb",
     "lib/rails3_assist/artifact/markers.rb",
     "lib/rails3_assist/artifact/migration.rb",
     "lib/rails3_assist/artifact/orm.rb",
     "lib/rails3_assist/artifact/view.rb",
     "lib/rails3_assist/base.rb",
     "lib/rails3_assist/base/class_methods.rb",
     "lib/rails3_assist/base/create.rb",
     "lib/rails3_assist/base/file_name.rb",
     "lib/rails3_assist/base/insert.rb",
     "lib/rails3_assist/base/read.rb",
     "lib/rails3_assist/base/remove.rb",
     "lib/rails3_assist/extensions/core_ext.rb",
     "lib/rails3_assist/rspec/macro.rb",
     "rails3_assist.gemspec",
     "rails_generator.log",
     "spec/fixtures/log/development.log",
     "spec/fixtures/log/production.log",
     "spec/fixtures/log/server.log",
     "spec/fixtures/log/test.log",
     "spec/load_spec.rb",
     "spec/rails3_assist/app/app_dirs_spec.rb",
     "spec/rails3_assist/app/app_file_names_spec.rb",
     "spec/rails3_assist/app/app_files_spec.rb",
     "spec/rails3_assist/artifact/controller/controller_spec.rb",
     "spec/rails3_assist/artifact/helper/helper_spec.rb",
     "spec/rails3_assist/artifact/mailer/mailer_spec.rb",
     "spec/rails3_assist/artifact/migration/migration_spec.rb",
     "spec/rails3_assist/artifact/model/model_spec.rb",
     "spec/rails3_assist/artifact/observer/observer_spec.rb",
     "spec/rails3_assist/artifact/orm/active_record_spec.rb",
     "spec/rails3_assist/artifact/orm/mongo_mapper_spec.rb",
     "spec/rails3_assist/artifact/orm/mongoid_spec.rb",
     "spec/rails3_assist/artifact/view_spec/view_controller_action_spec.rb",
     "spec/rails3_assist/artifact/view_spec/view_controller_default_action_specc.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/kristianmandrup/rails3-assist}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Assist in operating on Rails 3 artifacts including migrations}
  s.test_files = [
    "spec/load_spec.rb",
     "spec/rails3_assist/app/app_dirs_spec.rb",
     "spec/rails3_assist/app/app_file_names_spec.rb",
     "spec/rails3_assist/app/app_files_spec.rb",
     "spec/rails3_assist/artifact/controller/controller_spec.rb",
     "spec/rails3_assist/artifact/helper/helper_spec.rb",
     "spec/rails3_assist/artifact/mailer/mailer_spec.rb",
     "spec/rails3_assist/artifact/migration/migration_spec.rb",
     "spec/rails3_assist/artifact/model/model_spec.rb",
     "spec/rails3_assist/artifact/observer/observer_spec.rb",
     "spec/rails3_assist/artifact/orm/active_record_spec.rb",
     "spec/rails3_assist/artifact/orm/mongo_mapper_spec.rb",
     "spec/rails3_assist/artifact/orm/mongoid_spec.rb",
     "spec/rails3_assist/artifact/view_spec/view_controller_action_spec.rb",
     "spec/rails3_assist/artifact/view_spec/view_controller_default_action_specc.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 2.0.0.beta.19"])
      s.add_development_dependency(%q<rails-app-spec>, [">= 0.2.2"])
      s.add_runtime_dependency(%q<require_all>, [">= 1.1.0"])
      s.add_runtime_dependency(%q<migration_assist>, [">= 0.1.2"])
    else
      s.add_dependency(%q<rspec>, [">= 2.0.0.beta.19"])
      s.add_dependency(%q<rails-app-spec>, [">= 0.2.2"])
      s.add_dependency(%q<require_all>, [">= 1.1.0"])
      s.add_dependency(%q<migration_assist>, [">= 0.1.2"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 2.0.0.beta.19"])
    s.add_dependency(%q<rails-app-spec>, [">= 0.2.2"])
    s.add_dependency(%q<require_all>, [">= 1.1.0"])
    s.add_dependency(%q<migration_assist>, [">= 0.1.2"])
  end
end


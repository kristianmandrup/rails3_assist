# Rails3 Assistant

Includes various helpers to assist operating on a Rails 3 application.

## Install

<code>gem install rails3_assist</code>

## File Assistants

There are file assistants for the following Rails 3 artifacts:
* locale
* javascript
* stylesheet
* controller
* helper
* view
* model
* mailer
* observer
* permit
* view

* [name]_file
* [name]_files
* create_[name]_file
* remove_[name]_file
* remove_all__[name]s
* remove_[name]s

Example usage:

<pre>
remove_locales 'blip.en', 'blip.dk'	
remove_all_stylesheets
create_stylesheet 'my_styles.css' do
 %{
  .mystyle {font: bold;}	
}
end
remove_stylesheet 'my_styles.css'	
	
locale_files
locale_files 'permit.dk'
locale_files /permit/ do |files|
  # ...
end

view_files :person 
erb_view_files(:user).file_names.should include 'show.html.erb'
haml_view_files(:user)
</pre>

## Directory Assistants

There are dir helpers for the following 

* app
* config
* db
* public
* lib
* log
* doc
* test
* spec

* locale
* initializer
* javascript
* stylesheet
* controller
* helper
* view
* model
* mailer
* observer
* permit
* view

Example usage:

<pre>
	config_dir
	observer_dir_
	db_dir :root_path => MY_RAILS_ROOT
	rails_dir_for :migrations
	db_dir_for :migrations	
	config_dir_for :initializers, :root_path => MY_RAILS_ROOT
	app_dir_for :models
</pre>

## Special Rails mutators

* insert_application_config
* insert_before_application_init
* insert_after_application_init

Special file helpers:

* application_file
* environment_file
* seed_file

* read_[special]_file
* remove_[special]_file
* append_to_[special]_file
* replace_in_[special]_file :where => ... :with => ...
* remove_from_[special]_file

Example

<pre>
remove_from_application_file /config.root = (\w+?)/ 
append_to_seed_file do
  %{
  Person.new :name => 'Mike'
}
end
</pre>

### Usage

Set the root if not already set, then use the special assist methods to include the modules with all the goodies!
See the *Assistants* section below for more info on how to do this.

### Rails root

You have to set the class variable <code>Rails::Assist::Directory.rails_root</code> to the location of your Rails root directory if you are using this gem outside of Rails, fx for testing purposes or something. 

Note: If this variable is not set, it will assume it is used in a Rails app and therefore assume the root is  <code>Rails.root</code>.

In the specs of this projct, I use the *rails_root* class variable to avoid having to set a Rails app specific variable, which I deemed unnecessary for most of the tests.

### Assistants

Generators are often designed to create Rails 3 artifacts or update existing artifacts. It's often useful to include one or more Rails 3 artifact assistants along
with a generator assistant (see above). 

This combination greatly facilitates your work in developing the generator, as much of the heavy lifting will be done for you in the assistants.

To use a specific assistant/helper, simply call:

*assist_with [list of assistant symbols]*

Example:

<code>assist_with :controller, :model, :view, :permit</code>

Aliases: *use_helpers* and *use_helper*

Available helpers:

Artifacts
* controller
* model
* view
* helper
* observer
* mailer
* migration
* permit

Misc.
* file
* files
* directory

### Using Assistants

<pre>	
class MyGenerator < Rails::Generators:NamedBase
  extend Rails3::Assist::UseMacro

  use_orm :active_record
  use_helpers :file, :files, :controller, :observer, :migration
  ...
end
</pre>

### Assistant in RSpec

The assistants are preconfigured to be available within RSpec constructs. 

<pre>	
describe 'My Controller' do
  use_helpers :directory, :files, :helper, :mailer
  ...
end
</pre>
	
## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.

# Rails3 Assistant

Includes various helpers to assist operating on a Rails 3 application, including various Rails 3 artifacts, such as migrations etc.

## Rails Artifacts

Rails assist also includes various artifact libraries to help operate on different Rails 3 artifacts. 
These assist libraries mainly contain some common CRUD (Create, Read, Update, Delete) operations. 
The same API is shared in all the artifact assist libraries.
The following is a list of the main API, including an alias for each method. 

* create_[x] - new_[x])
* insert_into_[x] - update_[x]
* read_model - [x]_content
* remove_[x] - delete_[x]
* remove_[x]s - delete_[x]s

Rails 3 artifacts that have a CRUD assistant:

* controller
* helper
* mailer
* migration (pending!)
* model (insert bug!)
* observer
* view

## Model

* create_model (new_model)
* insert_into_model (update_model)

Create and insert for *model* operate according to the ORM currently used.
The ORM used is specified by calling <code>use_orm :[orm]</code> fx <code>use_orm :active_record</code>

### Usage

Set the root if not already set, then use the special assist/use methods to draw in the modules with all the goodies!

### Rails root

You have to set the class variable <code>Rails::Assist::App.rails_root_dir</code> to the location of your Rails root directory if you are using this gem outside of Rails,
Fx for testing purposes or something. It will default to use <code>Rails.root</code> if this class variable is not set to override it.

In the specs I use the *rails_root_dir* class variable to avoid having to set a Rails app specific variable, which I deemed unnecessary for most of the tests.

### Artifact assistants

Generators are often designed to create Rails 3 artifacts or update existing artifacts. It's often useful to include one or more Rails 3 artifact assistants along
with a generator assistant (see above). 

This combination greatly facilitates your work in developing the generator, as much of the heavy lifting will be done for you in the assistants.
To use a specific assistant/helper, simply call:

*assist_with [list of assistant symbols]*

Example:

<code>assist_with :app, :controller, :model, :view</code>

Aliases: *use_helpers* and *use_helper*

## Known issues

* View generation fails when action arg supplied :( To be fixed ASAP
 - rails3_assist/artifact/view.rb:7:in `[]' can't convert Symbol into Integer

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

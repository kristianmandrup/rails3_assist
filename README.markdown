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

Generators are often designed to create Rails 3 artifacts or update existing artifacts. It's often useful to include one or more Rails 3 artifact assisters along
with a generator assister (see above). 
This combination greatly facilitates your work in developing the generator, as much of the heavy lifting will be done for you in the assisters.
To use a helper, simply call:

*assist_with [list of helpers]*

Example:

<code>assist_with :app, :controller, :model, :view</code>

Aliases: *use_helpers* and *use_helper*

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

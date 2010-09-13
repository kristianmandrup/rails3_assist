require 'sugar-high/module'

module Rails3
  module Assist
    modules :app, :directory, :files, :file
    modules :artifact do
      nested_modules :directory, :files, :path
    end
  end
end
    
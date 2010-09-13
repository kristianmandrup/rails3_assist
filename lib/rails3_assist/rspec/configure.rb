require 'require_all'

module RSpec
  module Rails
    modules :content_matchers
  end
end

require_all File.dirname(__FILE__) + '/matchers'
require 'rspec'
require 'rspec/autorun'     

require 'require_all'
require 'rails3_assist/namespaces'
require 'rails3_assist/directory'

CLASS = Rails3::Assist::Directory::Container

describe Rails3::Assist::Directory::Container do
  # use_helper :directories

  describe '#rails_containers' do
    it "should return symbols list of rails 3 artifact containers" do
      CLASS.rails_containers.should include :controller, :mailer, :helper, :view, :model, :permit
    end
  end

  describe '#valid_container?' do
    it "should return true that since controller is a valid container" do
      CLASS.valid_container?(:controller).should be_true
    end

    it "should return since :unknown is NOT a valid container" do
      CLASS.valid_container?(:unknown).should be_false
    end
  end
end


require 'spec_helper'

CLASS = Rails3::Assist::Directory::Container

class Con
  include Rails3::Assist::Directory
end

class ConExt
  extend Rails3::Assist::Directory::Container  
end


describe Rails3::Assist::Directory::Container do
  # use_helper :directories

  context "using module methods directly" do
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
  
  context "module included into class" do
    describe '#rails_containers' do
      it "should return symbols list of rails 3 artifact containers" do
        Con.new.rails_containers.should include :controller, :mailer, :helper, :view, :model, :permit
      end
    end

    describe '#valid_container?' do
      it "should return true that since controller is a valid container" do
        Con.new.valid_container?(:controller).should be_true
      end
    end
  end

  context "module extended into class" do
    describe '#rails_containers' do
      it "should return symbols list of rails 3 artifact containers" do
        ConExt.rails_containers.should include :controller, :mailer, :helper, :view, :model, :permit
      end
    end

    describe '#valid_container?' do
      it "should return true that since controller is a valid container" do
        ConExt.valid_container?(:controller).should be_true
      end
    end
  end
end


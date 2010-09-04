require 'spec_helper'

CLASS = Rails3::Assist::App

class Helper
  include Rails3::Assist::Directory::App
  include Rails3::Assist::Directory::Root
end

describe 'controller' do
  before do                                         
    Rails3::Assist::Directory.rails_root = fixtures_dir
    @helper = Helper.new
  end

  after do
    remove_temp_dir 'tmp_rails'
  end
    
  it "should create basic root directories" do
    @helper.create_empty_tmp @helper.root_directories    
    @helper.root_dir.should have_dirs(@helper.root_directories)
  end

  it "should have basic app directories" do
    @helper.create_empty_tmp @helper.app_artifacts
    @helper.app_dir.should have_dirs(@helper.app_directories)
  end
end
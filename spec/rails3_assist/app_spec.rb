require 'spec_helper'

describe 'controller' do
  use_helper :app

  before do                                         
    Rails3::Assist::App.rails_root_dir = temp_dir('tmp_rails')
  end

  after do
    remove_temp_dir 'tmp_rails'
  end
    
  it "should create basic root directories" do
    create_empty_tmp root_directories    
    root_dir.should have_dirs root_directories
  end

  it "should have basic app directories" do
    create_empty_tmp app_artifacts
    app_dir.should have_dirs app_directories
  end
end
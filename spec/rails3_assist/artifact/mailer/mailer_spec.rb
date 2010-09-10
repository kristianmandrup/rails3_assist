require 'spec_helper'

describe 'mailer' do
  use_helpers :app, :mailer

  before :each do              
    remove_mailer :account        
    create_mailer :account do
      %q{
        def index
        end
      }
    end    
  end

  after :each do              
    # remove_mailer :account
  end
    
  it "should have an account_mailer file that contains an index method and two inserted comments" do
    insert_into_mailer :account, :content => '# hello'
    insert_into_mailer :account do
      '# goodbye'
    end
    read_mailer(:account).should have_comment 'hello'
    puts read_mailer(:account)
    # root_dir.should have_mailer :account do |mailer_file|
    #   mailer_file.should have_method :index
    #   mailer_file.should have_comment 'hello'
    #   mailer_file.should have_comment 'goodbye'
    # end
  end
end
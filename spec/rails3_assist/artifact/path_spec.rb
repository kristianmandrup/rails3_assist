require 'spec_helper'

CLASS = Rails3::Assist::Artifact::Path

class ArtDir
  include CLASS
end

describe Rails3::Assist::Artifact::Path do
  # use_helper :directories

  before do
    Rails3::Assist::Directory.rails_root = File.dirname (__FILE__)
    @test = ArtDir.new
  end

  describe '#artifact_path' do
    it "should return mailer directory name" do
      @test.artifact_path(:my_mailer, :mailer)
    end
  end
end


require 'rspec'
require 'rspec/autorun'     

require 'require_all'
require 'rails3_assist/namespaces'
require 'rails3_assist/artifact'

CLASS = Rails3::Assist::Artifact

class ArtDir
  include CLASS
end

describe Rails3::Assist::Artifact do
  # use_helper :directories

  before do
    Rails3::Assist::Directory.rails_root = File.dirname (__FILE__)
    @test = ArtDir.new
  end

  describe '#self.rails_artifacts' do
    it "should return mailer directory name" do
      CLASS.rails_artifacts.should include :mailer, :model
    end
  end

  describe '#valid_artifact?' do
    it "should be true that :model is a valid artifact" do
      CLASS.valid_artifact?(:model).should be_true
    end

    it "should be false that :unknown is a valid artifact" do
      CLASS.valid_artifact?(:unknown).should be_false
    end
  end

end

require 'rspec'
require 'rspec/autorun'     

require 'require_all'
require 'rails3_assist/namespaces'
require 'rails3_assist/directory'

CLASS = Rails3::Assist::Artifact::Directory

class ArtDir
  include CLASS
end

describe Rails3::Assist::Artifact::Directory do
  # use_helper :directories

  before do
    Rails3::Assist::Directory.rails_root = File.dirname (__FILE__)
    @test = ArtDir.new
  end

  Rails3::Assist::Artifact.app_artifacts.each do |name|
    eval %{
      describe '##{name}_dir' do
        it "should return #{name} directory name" do
          CLASS.#{name}_dir.should match /app\/\#{name}/
          @test.#{name}_dir.should match /app\/\#{name}/
        end
      end
    } 
  end
    
  [:initializer, :locale].each do |name|
    eval %{
      describe '##{name}_dir' do
        it "should return #{name} directory name" do
          CLASS.#{name}_dir.should match /config\/\#{name}/
          @test.#{name}_dir.should match /config\/\#{name}/
        end
      end
    } 
  end

  [:stylesheet, :javascript].each do |name|
    eval %{
      describe '##{name}_dir' do
        it "should return #{name} directory name" do
          CLASS.#{name}_dir.should match /public\/\#{name}/
          @test.#{name}_dir.should match /public\/\#{name}/
        end
      end
    } 
  end

end

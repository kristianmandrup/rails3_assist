require 'spec_helper'

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

  describe '#observer_dir' do
    it "should return observer directory name" do
      CLASS.observer_dir.should match /app\/models/
      @test.observer_dir.should match /app\/models/
    end
  end

  describe '#migration_dir' do
    it "should return migration directory name" do
      CLASS.migration_dir.should match /db\/migration/
      @test.migration_dir.should match /db\/migration/
    end
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

require_all File.dirname(__FILE__)

module Rails3::Assist::File
  module Special          
    module Methods
      # application_file, environment_file
      [:application, :environment, :routes, :boot].each do |name|
        class_eval %{
          def #{name}_file
            File.join(Rails3::Assist::Directory.config_dir, '#{name}.rb')
          end
        }
      end  

      def database_file
        File.join(Rails3::Assist::Directory.config_dir, 'database.yml')
      end

      def seed_file
        File.join(Rails3::Assist::Directory.db_dir, 'seeds.rb')
      end

      def gem_file
        File.join(Rails3::Assist::Directory.root_dir, 'Gemfile')
      end
      
      def has_gem? name
        File.new(gem_file).read =~ /gem\s+('|")#{name}\1/
      end

      def has_gem_version? name, version = nil
        File.new(gem_file).read =~ /gem\s+('|")#{name}\1,\s*('|")#{version}\2/
      end
    
      # read_application_file
      # append_to_application_file
      [:application, :environment, :seed, :gem, :routes, :boot, :database].each do |name|
        class_eval %{      
          def read_#{name}_file     
            fname = #{name}_file
            File.read(fname) if File.file?(fname)
          end

          def remove_#{name}_file
            File.delete #{name}_file
          end

          def append_to_#{name}_file content=nil, &block
            File.append(#{name}_file, content, &block)
          end

          def replace_in_#{name}_file options = {}, &block
            File.replace_content_from(#{name}_file, options, &block)
          end

          def remove_from_#{name}_file content=nil, &block
            File.remove_from(#{name}_file, content, &block)
          end
        }
      end    
    end
    
    include Methods
    extend Methods
    
    include Rails3::Assist::File::Application
    include Rails3::Assist::File::Environment    

    extend Rails3::Assist::File::Application
    extend Rails3::Assist::File::Environment    
  end
end

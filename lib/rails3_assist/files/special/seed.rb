module Rails3::Assist::App::Files
  module Special
    module Seed
      def seed_file
        File.join(db_dir, 'seed.rb')
      end  
  
      def remove_seed_file
        File.delete seed_file
      end
    end
  end
end
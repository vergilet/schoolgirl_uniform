# encoding: utf-8
# rails generate schoolgirl_uniform:install

module SchoolgirlUniform
  module Generators
    class InstallGenerator < Rails::Generators::Base

      desc "Creates initializer, routes and copy locale files to your application."
      class_option :orm

      def self.source_root
        @_schoolgirl_uniform_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def create_config_file
        template 'sguf.yml', File.join('config', 'sugarcrm.yml')
      end

      def create_initializer_file
        template 'initializer.rb', File.join('config', 'initializers', 'sugarcrm.rb')
      end

      # def copy_initializer_file
      #   copy_file "initializer.rb", "config/initializers/#{file_name}.rb"
      # end
      #
      # def install_assets
      #   require 'rails'
      #   require 'active_admin'
      # end
      #
      # def setup_routes
      #   route "mount Goldencobra::Engine => '/'"
      # end
      #
      # def self.source_root
      #   File.expand_path("../templates", __FILE__)
      # end

      # def create_migrations
      #   Dir["#{self.class.source_root}/migrations/*.rb"].sort.each do
      #   |filepath|
      #     name = File.basename(filepath)
      #     template "migrations/#{name}", "db/migrate/#{name}"
      #     sleep 1
      #   end
      # end
    end
  end
end
# encoding: utf-8
# rails generate schoolgirl_uniform:install

module SchoolgirlUniform
  module Generators
    class InstallGenerator < Rails::Generators::Base

      argument :controller_name, :type => :string, :default => "form"

      def self.source_root
        @_schoolgirl_uniform_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def create_initializer_file
        create_file(
          "app/controllers/#{controller_name.underscore}_controller.rb",
          "class #{controller_name.camelcase}Controller < SchoolgirlUniform::BaseController\n" +
          "end"
        )
      end

      def setup_routes
        route(
        "resource :#{controller_name.underscore}, controller: '#{controller_name.underscore}', only: [:show, :create] do\n" +
            "\t\tcollection do\n" +
            "\t\t\tget  :current\n" +
            "\t\t\tpost :next\n" +
            "\t\t\tget  :previous\n" +
            "\t\t\tget  :finish\n" +
          "\t\tend\n" +
        "\tend")
      end
    end
  end
end
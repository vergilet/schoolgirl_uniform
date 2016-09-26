# encoding: utf-8
# rails generate schoolgirl_uniform:install MyForm

module SchoolgirlUniform
  module Generators
    class InstallGenerator < Rails::Generators::Base

      argument :controller_name, :type => :string, :default => "form"

      def self.source_root
        @_schoolgirl_uniform_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def create_initializer_file
        template "wizard.html.erb", "app/views/#{controller_name.underscore}/_wizard.html.erb"
        template "show.html.erb", "app/views/#{controller_name.underscore}/show.html.erb"
        template "steps/first_step.html.erb", "app/views/#{controller_name.underscore}/steps/_first_step.html.erb"
        template "steps/last_step.html.erb", "app/views/#{controller_name.underscore}/steps/_last_step.html.erb"
        template "forms/template_form.rb.erb", "app/forms/#{controller_name.underscore}_form.rb"
        template "controllers/template_controller.rb.erb", "app/controllers/#{controller_name.underscore}_controller.rb"
      end

      def setup_routes
        route navigtation_resources
      end

      private

      def navigtation_resources
        <<-FILE
resource :#{controller_name.underscore}, controller: '#{controller_name.underscore}', only: [:show, :create] do
    collection do
      get  :current
      post :next
      get  :previous
      get  :finish
    end
  end
        FILE
      end

      def main_form
        "class #{controller_name.camelcase}Form < SchoolgirlUniform::BaseForm\n" +
            "\n"+
            "\t# attribute :user_id, String\n"+
            "\n"+
            "\tdef initialize(options = {})\n" +
            "\t\tinitialize_attributes(options)\n" +
            "\tend\n" +
        "end"
      end

      def main_view
        ''
      end

      def copy_wizard
        template "wizard.html.erb", "app/views/#{controller_name.underscore}/_wizard.html.erb"
      end
    end
  end
end

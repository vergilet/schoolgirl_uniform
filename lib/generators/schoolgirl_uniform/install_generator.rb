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
        copy_file "wizard.html.erb", "app/views/#{controller_name.underscore}/_wizard.html.erb"
        copy_file "show.html.erb", "app/views/#{controller_name.underscore}/show.html.erb"
        copy_file "steps/first_step.html.erb", "app/views/#{controller_name.underscore}/steps/_first_step.html.erb"
        copy_file "steps/last_step.html.erb", "app/views/#{controller_name.underscore}/steps/_last_step.html.erb"

        create_file("app/forms/#{controller_name.underscore}_form.rb", main_form)

        create_file(
          "app/controllers/#{controller_name.underscore}_controller.rb", main_controller
        )

      end

      def setup_routes
        route navigtation_resources
      end

      private

      def navigtation_resources
        "resource :#{controller_name.underscore}, controller: '#{controller_name.underscore}', only: [:show, :create] do\n" +
            "\t\tcollection do\n" +
            "\t\t\tget  :current\n" +
            "\t\t\tpost :next\n" +
            "\t\t\tget  :previous\n" +
            "\t\t\tget  :finish\n" +
            "\t\tend\n" +
         "\tend"
      end

      def main_controller
        "class #{controller_name.camelcase}Controller < SchoolgirlUniform::BaseController\n" +
            "\n"+
            "\tdef initialize_form\n" +
            "\t\t@form = #{controller_name.camelcase}Form.new(session[session_key] || {})\n" +
            "\t\t \# @form.user_id = current_user.id\n" +
            "\tend\n" +
            "\n" +
            "\tdef session_key\n" +
            "\t\t:#{controller_name.underscore}\n" +
            "\tend\n" +
        "end"
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
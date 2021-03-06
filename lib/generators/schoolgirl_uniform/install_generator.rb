# encoding: utf-8
# rails generate schoolgirl_uniform:install MyForm

module SchoolgirlUniform
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      argument :controller_name, type: :string, default: "form"

      def create_initializer_file
        copy_file "wizard.html.erb", "app/views/#{file_name}/_wizard.html.erb"
        copy_file "show.html.erb", "app/views/#{file_name}/show.html.erb"
        copy_file "steps/first_step.html.erb", "app/views/#{file_name}/steps/_first_step.html.erb"
        copy_file "steps/last_step.html.erb", "app/views/#{file_name}/steps/_last_step.html.erb"
        template "forms/template_form.rb.erb", "app/forms/#{file_name}_form.rb"
        template "controllers/template_controller.rb.erb", "app/controllers/#{file_name}_controller.rb"
      end

      def setup_routes
        route <<-FILE
resource :#{file_name}, controller: '#{file_name}', only: [:show, :create] do
    collection do
      get  :current
      post :next
      get  :previous
      get  :finish
    end
  end
        FILE
      end
    end
  end
end

module SchoolgirlUniform
  class Carrier

    def initialize(form, paths = {})
      @form = form
      @current_step_path = paths[:current]
      @previous_step_path = paths[:previous]
    end

    def current_step_path
      @current_step_path
    end

    def previous_step_path
      @previous_step_path
    end

    private

    attr_reader :form
  end
end
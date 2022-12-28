module SchoolgirlUniform
  class Carrier

    def initialize(form, paths = {})
      @form = form
      @next_step_path = paths[:next]
      @current_step_path = paths[:current]
      @previous_step_path = paths[:previous]
      @create_path = paths[:create]
    end

    def next_step_path
      @next_step_path
    end

    def current_step_path
      @current_step_path
    end

    def previous_step_path
      @previous_step_path
    end

    def create_path
      @create_path
    end

    private

    attr_reader :form
  end
end
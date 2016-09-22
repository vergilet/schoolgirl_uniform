module SchoolgirlUniform
  class Carrier

    def initialize form
      @form = form
    end

    def next_step_path
      ''
    end

    def current_step_path
      ''
    end

    def previous_step_path
      ''
    end

    def create_path
      ''
    end

    private

    attr_reader :form
  end
end
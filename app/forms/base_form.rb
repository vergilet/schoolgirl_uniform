module SchoolgirlUniform
  class BaseForm
    include Uniformable
    attribute :step, String
    attribute :base_errors, Object
    # attribute :user_id, String

    def self.steps
      %w(first_step last_step)
    end

    def initialize(options = {})
      initialize_attributes(options)
    end
  end
end
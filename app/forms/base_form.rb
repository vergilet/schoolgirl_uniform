module SchoolgirlUniform
  class BaseForm
    include Uniformable
    attribute :step, String
    attribute :base_errors, Object
    # attribute :user_id, String

    def initialize(options = {})
      initialize_attributes(options)
    end
  end
end
module SchoolgirlUniform
  class BaseForm

    include SchoolgirlUniform::Uniformable
    attribute :step, String
    attr_reader :identifier

    def self.steps
      raise NotImplementedError
    end

    def self.step_names
      raise NotImplementedError
    end

    def initialize(options = {})
      initialize_attributes(options)
    end
  end
end
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

    steps.each do |method_name|
      define_singleton_method "#{method_name}?" do
        proc { on_step(method_name) }
      end
    end

    def initialize(options = {})
      initialize_attributes(options)
    end
  end
end
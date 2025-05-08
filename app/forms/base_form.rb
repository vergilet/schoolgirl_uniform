module SchoolgirlUniform
  class BaseForm
    include SchoolgirlUniform::Uniformable

    attribute :step, String
    attr_reader :identifier

    def self.inherited(child_class)
      super
      child_class.extend StepDefiner
    end

    def initialize(options = {})
      initialize_attributes(options)
    end
  end
end
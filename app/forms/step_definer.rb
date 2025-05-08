module StepDefiner
  module ClassMethods
    attr_reader :defined_steps

    def steps(*step_names)
      @defined_steps ||= []
      @defined_steps.concat(step_names.flatten.map(&:to_s))

      @defined_steps.each do |step|
        unless method_defined?("#{step}?")
          define_singleton_method "#{step}?" do
            proc { on_step(step) }
          end
        end
      end
    end
  end

  def self.extended(base)
    base.extend(ClassMethods)
  end
end
module SchoolgirlUniform
  module Uniformable

    def self.included(base)
      base.include ActiveModel::Model
      base.include Virtus.model
    end

    def initialize(options = {})
      initialize_attributes(options)
    end

    def save!
      raise NotImplementedError
    end

    def current_step
      step || steps.first
    end

    def next_step
      return if last_step? || !valid?
      shift_step(1)
    end

    def previous_step
      shift_step(-1)
    end

    def first_step?
      current_step == steps.first
    end

    def last_step?
      current_step == steps.last
    end

    def steps
      self.class.steps
    end

    def current_step_index
      steps.index(current_step)
    end

    private

    def initialize_attributes(new_attributes)
      self.errors ||= ActiveModel::Errors.new(self)
      self.attributes = defaults.merge(new_attributes)
    end

    def defaults
      { }
    end

    def persisted?
      false
    end

    def shift_step(delta)
      self.step = steps[steps.index(current_step) + delta]
    end

    def on_step(step)
      current_step == step
    end
  end
end
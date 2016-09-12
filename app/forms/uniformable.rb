module SchoolgirlUniform
  module Uniformable

    def self.included(base)
      base.include ActiveModel::Model
      base.include Virtus.model
    end

    def self.steps
      %w()
    end

    def initialize(options = {})
      initialize_attributes(options)
    end

    def valid?
      current_step_errors.empty?
    end

    def save!; end

    def current_step
      step || steps.first
    end

    def next_step
      return if last_step? || !current_step_valid?
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
      self.attributes = defaults.merge(new_attributes)
    end

    def defaults
      { }
    end

    def persisted?
      false
    end

    def current_step_errors
      { }
    end

    def errors_full_messages
      current_step_errors.full_messages
    end

    def all_error_keys
      (all_errors.keys + base_errors.keys).map(&:to_s)
    end

    def all_errors
      []
    end

    def current_step_valid?
      self.valid?
    end

    def shift_step(delta)
      self.step = steps[steps.index(current_step) + delta]
    end
  end
end
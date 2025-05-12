module SchoolgirlUniform
  module Uniformable
    module ClassMethods
      def steps(*step_list)
        @defined_steps = step_list.flatten.map(&:to_s)
        attribute :step, :string, default: -> { @defined_steps.first }

        @defined_steps.each do |step_name|
          helper_method_name = "#{step_name}?"
          unless method_defined?(helper_method_name)
            define_method helper_method_name do
              current_step == step_name
            end
          end
        end
      end

      def defined_steps
        @defined_steps || []
      end

      def step_names
        defined_steps
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
      base.include ActiveModel::Model
      base.include ActiveModel::Attributes
    end

    def save!
      raise NotImplementedError, "#{self.class.name} must implement #save!"
    end

    def save_form!
      unless defined?(ActiveRecord::Base)
        raise "ActiveRecord::Base not available for transaction"
      end

      ActiveRecord::Base.transaction do
        save!
      rescue => e
        if e.respond_to?(:record) && e.record.respond_to?(:errors)
          e.record.errors.each { |error| errors.add(error.attribute, error.message) }
        else
          errors.add(:base, e.message)
        end
        raise ActiveRecord::Rollback
      end
      errors.empty?
    end

    def current_step
      step
    end

    def next_step
      return if last_step? || !valid?
      shift_step(1)
    end

    def previous_step
      return if first_step?
      shift_step(-1)
    end

    def first_step?
      current_step == self.class.defined_steps.first
    end

    def last_step?
      current_step == self.class.defined_steps.last
    end

    def steps
      self.class.defined_steps
    end

    def step_names
      self.class.step_names
    end

    def current_step_index
      Array(steps).index(current_step)
    end

    def persisted?
      false
    end

    private

    def shift_step(delta)
      idx = current_step_index
      return unless idx

      new_index = idx + delta
      self.step = steps[new_index] if new_index >= 0 && new_index < steps.length
    end

  end
end

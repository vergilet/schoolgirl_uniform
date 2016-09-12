module SchoolgirlUniform
  module Carriers
    class Carrier

      def initialize form
        @form = form
      end

      def next_step_path
        raise NotImplementedError.new
      end

      def current_step_path
        raise NotImplementedError.new
      end

      def previous_step_path
        raise NotImplementedError.new
      end

      def create_path
        raise NotImplementedError.new
      end

      private

      attr_reader :form
    end
  end
end
module SystemHealth
  module Monitors
    class Base
      attr_reader :error_messages

      def initialize
        @error_messages = []
        add_error_messages
      end

      def error_count
        error_messages.count
      end

      def description
        raise
      end

      private

      def add_error_messages
        add_error_message(description) if bad_data?
      end

      def add_error_message(message)
        @error_messages << message
      end

      def bad_data?
        raise
      end
    end
  end
end

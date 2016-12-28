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

      private

      def add_error_messages
        raise
      end

      def add_error_message(message)
        error_messaages << message
      end
    end
  end
end

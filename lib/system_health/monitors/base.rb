module SystemHealth
  module Monitors
    class Base
      def error_count
        error_messages.count
      end
    end
  end
end

module SystemHealth
  class Monitor
    def initialize(monitor_classes)
      @monitor_classes = monitor_classes
    end

    def error_count
      monitors.sum(&:error_count)
    end

    def error_messages
      monitors.flat_map(&:error_messages)
    end

    private
    attr_reader :monitor_classes

    def monitors
      @monitors ||= monitor_classes.map(&:new)
    end
  end
end

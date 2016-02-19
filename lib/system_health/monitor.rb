module SystemHealth
  class Monitor
    def initialize(monitor_classes)
      @monitor_classes = monitor_classes
    end

    def as_json(options = nil)
      {
        error_count: error_count,
        messages: messages
      }
    end

    def http_status
      error_count > 0 ? 500 : 200
    end

    private
    attr_reader :monitor_classes

    def error_count
      monitors.sum(&:error_count)
    end

    def messages
      monitors.flat_map(&:error_messages)
    end

    def monitors
      [].tap do |array|
        monitor_classes.each do |monitor_class|
          array << monitor_class.new
        end
      end
    end
  end
end

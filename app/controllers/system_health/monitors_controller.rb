module SystemHealth
  class MonitorsController < ApplicationController
    http_basic_authenticate_with \
      name: ENV['SYSTEM_HEALTH_USERNAME'],
      password: ENV['SYSTEM_HEALTH_PASSWORD']

    def show
      render :json => monitor.as_json, :status => monitor.http_status
    end

    private

    def monitor
      @monitor ||= SystemHealth::Monitor.new(SYSTEM_HEALTH_MONITOR_CLASSES)
    end
  end
end

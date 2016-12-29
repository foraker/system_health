require 'system_health/configuration'
require 'system_health/engine'
require 'system_health/monitor'
require 'system_health/version'
require 'system_health/monitors/base'
require 'system_health/monitors/sql'

module SystemHealth
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

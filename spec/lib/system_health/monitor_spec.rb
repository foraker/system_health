require 'active_support/all'
require_relative '../../../lib/system_health/monitor'
require_relative '../../../lib/system_health/monitors/base'

module SystemHealth
  describe Monitor do

    class MonitorDouble < Monitors::Base
      def error_messages
        []
      end
    end

    let(:monitor_classes) { [MonitorDouble] }
    let(:monitor) { described_class.new(monitor_classes) }

    context 'when errors' do
      before do
        allow_any_instance_of(MonitorDouble).
          to receive(:error_messages).
          and_return(['something broke'])
      end

      describe '#as_json' do
        it 'returns error_count and messages' do
          expect(monitor.as_json).to eq({
            error_count: 1,
            messages: ['something broke']
          })
        end
      end

      describe '#http_status' do
        it 'returns 500' do
          expect(monitor.http_status).to eq 500
        end
      end
    end

    context 'when no errors' do
      describe '#as_json' do
        it 'returns error_count and messages' do
          expect(monitor.as_json).to eq({
            error_count: 0,
            messages: []
          })
        end
      end

      describe '#http_status' do
        it 'returns 200 when no errors' do
          expect(monitor.http_status).to eq 200
        end
      end
    end
  end
end

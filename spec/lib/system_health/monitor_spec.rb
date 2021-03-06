require 'active_support/all'
require_relative '../../../lib/system_health/monitor'
require_relative '../../../lib/system_health/monitors/base'

module SystemHealth
  describe Monitor do

    context 'when errors' do
      class MonitorDouble < Monitors::Base
        def description
          'hello'
        end

        private

        def bad_data?
          true
        end
      end

      let(:monitor_classes) { [MonitorDouble] }
      let(:monitor) { described_class.new(monitor_classes) }

      before do
        allow_any_instance_of(MonitorDouble).
          to receive(:error_messages).
          and_return(['something broke'])
      end

      describe '#error_count' do
        it 'returns error count' do
          expect(monitor.error_count).to eq(1)
        end
      end

      describe '#messages' do
        it 'returns error messages' do
          expect(monitor.error_messages).to eq(['something broke'])
        end
      end
    end

    context 'when no errors' do
      class MonitorDouble < Monitors::Base
        def description
          'hello'
        end

        private

        def bad_data?
          false
        end
      end

      let(:monitor_classes) { [MonitorDouble] }
      let(:monitor) { described_class.new(monitor_classes) }

      describe '#error_count' do
        it 'returns error count' do
          expect(monitor.error_count).to eq(0)
        end
      end

      describe '#messages' do
        it 'returns error messages' do
          expect(monitor.error_messages).to eq([])
        end
      end
    end
  end
end

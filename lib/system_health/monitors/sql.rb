module SystemHealth
  module Monitors
    class Sql < Base

      private

      def bad_data?
        ActiveRecord::Base.connection.execute(sql).count > 0
      end

      def sql
        raise
      end
    end
  end
end


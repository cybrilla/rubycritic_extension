require 'rubycritic/commands/status_reporter'

module RubyCriticExtension
  module Command
    class StatusReporter < ::RubyCritic::Command::StatusReporter

      def initialize(options)
      	super(options)
      end

      def status_message=(status_message)
        @status_message = status_message
      end
    end
  end
end
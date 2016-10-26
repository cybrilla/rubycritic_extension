# frozen_string_literal: true
require 'rubycritic_extension/commands/status_reporter'
require 'rubycritic/commands/base'

module RubyCriticExtension
  module Command
    class Base < ::RubyCritic::Command::Base
      def initialize(options)
        super(options)
        @options = options
        @status_reporter = RubyCriticExtension::Command::StatusReporter.new(@options)
      end

      def execute
        raise NotImplementedError
      end
    end
  end
end

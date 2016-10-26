# frozen_string_literal: true
require 'rubycritic_extension/configuration'
require 'rubycritic/command_factory'

module RubyCriticExtension
  class CommandFactory < ::RubyCritic::CommandFactory
    def self.create(options = {})
      super(options)
      Config.set(options)
      command_class(Config.mode).new(options)
    end

    def self.command_class(mode)
      case mode
      when :version
        require 'rubycritic/commands/version'
        ::RubyCritic::Command::Version
      when :help
        require 'rubycritic/commands/help'
        ::RubyCritic::Command::Help
      when :ci
        require 'rubycritic/commands/ci'
        ::RubyCritic::Command::Ci
      else
        require 'rubycritic_extension/commands/default'
        Command::Default
      end
    end
  end
end

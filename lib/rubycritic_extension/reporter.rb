# frozen_string_literal: true
module RubyCriticExtension
  module Reporter
    def self.generate_report(analysed_modules)
      report_generator_class.new(analysed_modules).generate_report
    end

    def self.report_generator_class
      case Config.format
      when :json
        require 'rubycritic/generators/json_report'
        ::RubyCritic::Generator::JsonReport
      when :console
        require 'rubycritic/generators/console_report'
        ::RubyCritic::Generator::ConsoleReport
      else
        require 'rubycritic_extension/generators/html_report'
        Generator::HtmlReport
      end
    end
  end
end

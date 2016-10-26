# frozen_string_literal: true
require 'rubycritic_extension/core/analysed_modules_collection'
require 'rubycritic/analysers_runner'
module RubyCriticExtension
  class AnalysersRunner < ::RubyCritic::AnalysersRunner

    def initialize(paths)
      super(paths)
    end

    def analysed_modules
      @analysed_modules ||= AnalysedModulesCollection.new(@paths)
    end
  end
end

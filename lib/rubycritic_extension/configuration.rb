# frozen_string_literal: true
require 'rubycritic/configuration'
module RubyCriticExtension
  class Configuration < ::RubyCritic::Configuration
    attr_accessor :base_branch, :feature_branch, :compare_between_branches ,:base_branch_score, :feature_branch_score, :quality_flag,
                  :base_root_directory, :feature_root_directory, :build_root_directory, :set_location, :base_branch_flag, :feature_branch_flag, :build_flag, :merge_request_id, :difference_score

    def set(options)
      self.mode = options[:mode] || :default
      self.root = options[:root] || 'tmp/rubycritic'
      self.format = options[:format] || :html
      self.deduplicate_symlinks = options[:deduplicate_symlinks] || false
      self.suppress_ratings = options[:suppress_ratings] || false
      self.open_with = options[:open_with]
      self.no_browser = options[:no_browser]
      self.base_branch = options[:base_branch]
      self.feature_branch = options[:feature_branch]
      self.compare_between_branches = options[:compare_between_branches]
      self.set_location = false
      self.feature_branch_flag = false
      self.base_branch_flag = false
      self.build_flag = false
      self.merge_request_id = options[:merge_request_id]
    end
  end

  module Config
    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.set(options = {})
      configuration.set(options)
    end

    def self.method_missing(method, *args, &block)
      configuration.public_send(method, *args, &block)
    end

    def self.respond_to_missing?(symbol, include_all = false)
      configuration.respond_to_missing?(symbol) || super
    end
  end
end
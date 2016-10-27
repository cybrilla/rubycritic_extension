require 'rubycritic/generators/html_report'
require 'fileutils'
require 'rubycritic/configuration'
require 'rubycritic/generators/html/overview'
require 'rubycritic/generators/html/smells_index'
require 'rubycritic/generators/html/code_index'
require 'rubycritic/generators/html/code_file'

module RubyCriticExtension
  module Generator
    class HtmlReport < ::RubyCritic::Generator::HtmlReport
    	def initialize(analysed_modules)
        @analysed_modules = analysed_modules
      end

      def generate_report
        create_directories_and_files
        copy_assets_to_report_directory
        puts "New critique at #{report_location}"
        browser.open unless ::RubyCritic::Config.no_browser
        report_location
      end

      def browser
        @browser ||= ::RubyCritic::Browser.new(report_location)
      end

      private

      def create_directories_and_files
        Array(generators).each do |generator|
          FileUtils.mkdir_p(generator.file_directory)
          File.open(generator.file_pathname, 'w+') do |file|
            file.write(generator.render)
          end
        end
      end

      def generators
        [overview_generator, code_index_generator, smells_index_generator] + file_generators
      end

      def overview_generator
        @overview_generator ||= ::RubyCritic::Generator::Html::Overview.new(@analysed_modules)
      end

      def code_index_generator
        ::RubyCritic::Generator::Html::CodeIndex.new(@analysed_modules)
      end

      def smells_index_generator
        ::RubyCritic::Generator::Html::SmellsIndex.new(@analysed_modules)
      end

      def file_generators
        @analysed_modules.map do |analysed_module|
          ::RubyCritic::Generator::Html::CodeFile.new(analysed_module)
        end
      end

      def copy_assets_to_report_directory
        FileUtils.cp_r(ASSETS_DIR, Config.root)
      end

      def report_location
        code_index_generator.file_href
      end
    end
  end
end
# require 'rubycritic/generators/html_report'
# require 'rubycritic_extension/configuration'

# module RubyCriticExtension
#   module Generator
#     class HtmlReport < ::RubyCritic::Generator::HtmlReport
#     	def initialize(analysed_modules)
#     		super(analysed_modules)
#     	end

#     	def generate_report
#         create_directories_and_files
#         copy_assets_to_report_directory
#         puts "New critique at #{report_location}"
#         browser.open unless Config.no_browser
#         report_location
#       end
#     end
#   end
# end
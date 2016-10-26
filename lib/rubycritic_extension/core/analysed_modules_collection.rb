require 'rubycritic/source_locator'
require 'rubycritic/core/analysed_module'
require 'rubycritic/core/analysed_modules_collection'

module RubyCriticExtension
  class AnalysedModulesCollection < ::RubyCritic::AnalysedModulesCollection

  	def initialize(paths, modules = nil)
  		super(paths)
	    unless modules.nil?
 	    	@modules = ::RubyCritic::SourceLocator.new(paths).pathnames.map do |pathname|
 	      	mod = modules.find { |mod|  mod.pathname == pathname }
 	      	::RubyCritic::AnalysedModule.new(pathname: mod.pathname, name: mod.name, smells: mod.smells, churn: mod.churn, committed_at: mod.committed_at, complexity: mod.complexity, duplication: mod.duplication, methods_count: mod.methods_count)
 	    	end  
 	   	else
 	     	@modules = ::RubyCritic::SourceLocator.new(paths).pathnames.map do |pathname|
 	      	::RubyCritic::AnalysedModule.new(pathname: pathname)
 	     	end
 	   	end 
  	end

  	def where(module_names)
  	  @modules.find_all { |mod|  module_names.include? mod.name }
  	end
  end
end	

require '../test/test_helper'
require '../lib/rubycritic_extension/core/analysed_modules_collection'

describe RubyCriticExtension::AnalysedModulesCollection do

  describe '.new' do
  	subject { RubyCriticExtension::AnalysedModulesCollection.new(paths) }

  	context 'with an empty path' do
      let(:paths) { '' }

      it 'returns an empty collection' do
        subject.count.must_equal 0
      end
    end

    context 'with a list of files' do
      let(:paths) { %w(../test/samples/doesnt_exist.rb ../test/samples/unparsable.rb ../test/samples/empty.rb) }

      it 'registers one AnalysedModule element per existent file' do
        subject.count.must_equal 2
        subject.all? { |a| a.is_a?(RubyCritic::AnalysedModule) }.must_equal true
      end
    end
  end

  describe 'initializing the analysed_modules' do
  	subject { RubyCriticExtension::AnalysedModulesCollection.new(paths, analysed_modules) }

    context 'with a list of files and initializing analysed modules with pre existing values' do
      let(:paths) { %w(../test/samples/empty.rb) }
      let(:analysed_modules) { [::RubyCritic::AnalysedModule.new(pathname: Pathname.new('../test/samples/empty.rb'), name: 'Name', smells: [], churn: 2, committed_at: Time.now, complexity: 2, duplication: 0, methods_count: 2)] }

      it 'registers one AnalysedModule element per existent file' do
      	subject.count.must_equal 1
      	analysed_module = subject.first
      	analysed_module.pathname.must_equal Pathname.new('../test/samples/empty.rb')
      	analysed_module.name.must_equal 'Name'
      	analysed_module.churn.must_equal 2
      	analysed_module.complexity.must_equal 2
      	analysed_module.duplication.must_equal 0
      	analysed_module.methods_count.must_equal 2
      end
    end
  end

  describe 'querying analysed_modules_collection' do
  	subject { RubyCriticExtension::AnalysedModulesCollection.new(paths, analysed_modules) }

    context 'with a list of files and initializing analysed modules with pre existing values' do
      let(:paths) { %w(../test/samples/empty.rb ../test/samples/unparsable.rb) }
      let(:analysed_modules) { [::RubyCritic::AnalysedModule.new(pathname: Pathname.new('../test/samples/empty.rb'), name: 'Empty'),
      													::RubyCritic::AnalysedModule.new(pathname: Pathname.new('../test/samples/unparsable.rb'), name: 'Unparsable'),
      													] 
      												}

      it 'registers one AnalysedModule element per existent file' do
      	subject.count.must_equal 2
      	subject.where(['Empty']).count.must_equal 1
      	subject.where(['Unparsable']).count.must_equal 1
      end
    end
  end
end
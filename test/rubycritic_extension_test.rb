require '../test/test_helper'
require '../lib/rubycritic_extension/version'

class RubycriticExtensionTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RubycriticExtension::VERSION
  end

  def test_it_does_something_useful
    assert true
  end
end

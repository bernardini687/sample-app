require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title,         'SampleApp'
    assert_equal full_title('help'), 'Help | SampleApp'
  end
end
require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'should get home' do
    get static_pages_home_url
    assert_response :success
    assert_select 'title', 'Home | SampleApp'
  end

  test 'should get help' do
    get static_pages_help_url
    assert_response :success
    assert_select 'title', 'Help | SampleApp'
  end

  test 'should get about' do
    get static_pages_about_url
    assert_response :success
    assert_select 'title', 'About | SampleApp'
  end
end

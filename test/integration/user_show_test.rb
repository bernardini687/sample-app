require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:archer)
    @other = users(:lana)
  end

  test 'should display user when activated' do
    get user_path(@other)
    assert_template 'users/show'
    assert_response :success
  end

  test 'should redirect to root_url when user not activated' do
    @other.toggle!(:activated)
    get user_path(@other)
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
  end
end

require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:oscar)
    @non_admin = users(:archer)
  end

  test 'index as admin including pagination and delete links' do
    log_in_as(@admin)
    # Deactivate User to test it does not show up again
    User.paginate(page: 1).first.toggle!(:activated)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    assigns(:users).each do |user|
      assert user.activated?
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: '(delete)'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test 'index as non-admin' do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: '(delete)', count: 0
  end
end

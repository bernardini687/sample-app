require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: '',
                                          email: 'user@invalid',
                                          password: 'foo',
                                          password_confirmation: 'bar' } }
    end
    assert_template 'users/new'
    assert_select   '#error_explanation'
    assert_select   '.field_with_errors'
    assert_select   'form[action="/signup"]'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: 'rails tutorial',
                                          email: 'example@railstutorial.org',
                                          password: 'asdfjk',
                                          password_confirmation: 'asdfjk' } }
    end
    follow_redirect! # get user_path(User.first)
    assert_template 'users/show'
    assert_select   '.alert-success'
    assert_select   'title', full_title(User.first.name)
  end
end

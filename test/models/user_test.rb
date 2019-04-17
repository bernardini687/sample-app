require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: 'Example User',
      email: 'example@user.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ' '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'name should be less than 33 characters' do
    @user.name = 'a' * 33
    assert_not @user.valid?
  end

  test 'email should be less than 256 characters' do
    @user.email = 'a' * 247 + '@user.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    %w[
      user@example.com
      USER@foo.COM
      A_US-ER@foo.bar.org
      first.last@foo.jp
      alice+bob@baz.cn
    ].each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    %w[
      user@example,com
      user_at_foo.org
      user.name@example.
      foo@bar_baz.com
      foo@bar+baz.com
      foo@bar..com
      foo@bar.coding
    ].each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    user_copy = @user.dup
    user_copy.email.upcase!
    @user.save
    assert_not user_copy.valid?
  end

  test 'name should be saved as titlecased' do
    user_name = 'leo cat'
    @user.name = user_name
    @user.save
    assert_equal user_name.titlecase, @user.reload.name
  end

  test 'email should be saved as lower-case' do
    mixed_mail = 'EXAMPLE@user.com'
    @user.email = mixed_mail
    @user.save
    assert_equal mixed_mail.downcase, @user.reload.email
  end

  test 'password should be present' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should be more than 5 characters' do
    @user.password = @user.password_confirmation = '1' * 5
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?(:remember, '')
  end

  test 'microposts should be destroyed' do
    @user.save
    @user.microposts.create!(content: 'x')
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end

require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:oscar)
    @micropost = @user.microposts.build(content: 'Sunny.')
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'should have a user id' do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test 'content should be present' do
    @micropost.content = ' '
    assert_not @micropost.valid?
  end

  test 'content should be less than 141 characters' do
    @micropost.content = 'x' * 141
    assert_not @micropost.valid?
  end

  test 'order should be most recent first' do
    assert_equal microposts(:most_recent), Micropost.first
  end
end

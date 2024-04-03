# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user = User.new(email: 'tyrrell@example.com')
    assert_equal 'tyrrell@example.com', user.name_or_email

    user.name = 'tyrrell'
    assert_equal 'tyrrell', user.name_or_email
  end
end

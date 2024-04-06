# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    user1 = User.create!(email: 'foo@example.com', password: 'password')
    user2 = User.create!(email: 'bar@example.com', password: 'password')
    report = user1.reports.create!(title: '初めまして', content: '初めての日報です')
    assert report.editable?(user1)
    assert_not report.editable?(user2)
  end

  test '#created_on' do
    user = User.create!(email: 'tyrrell@example.com', password: 'password')
    report = user.reports.create!(title: '初めまして', content: '初めての日報です', created_at: Date.new(2024, 4, 1))
    assert_equal Date.new(2024, 4, 1), report.created_on
  end
end

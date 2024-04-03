# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    user1 = User.create!(email: 'Alice@example.com', password: 'password')
    user2 = User.create!(email: 'Bob@example.com', password: 'password')
    report = user1.reports.create!(title: '初めまして', content: '初めての日報です')

    assert report.editable?(user1)
    assert_not report.editable?(user2)
  end
end

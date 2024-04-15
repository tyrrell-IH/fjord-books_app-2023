# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    user1 = users(:Alice)
    user2 = users(:Bob)
    report = user1.reports.create!(title: '初めまして', content: '初めての日報です')

    assert report.editable?(user1)
    assert_not report.editable?(user2)
  end

  test '#created_on' do
    user = users(:Alice)
    report = user.reports.create!(title: '初めまして', content: '初めての日報です', created_at: Date.new(2024, 4, 1))

    assert_equal Date.new(2024, 4, 1), report.created_on
  end

  test '#save_mentions' do
    report1 = users(:Alice).reports.create!(title: 'Aliceの日報サンプル', content: 'サンプルです')
    report2 = users(:Bob).reports.create!(title: 'Bobの日報サンプル', content: "http://localhost:3000/reports/#{report1.id}")

    assert_includes(report2.mentioning_reports, report1)

    report2[:content] = 'report1を参照しない'
    report2.save!

    assert_not_includes(report2.reload.mentioning_reports, report1)

    report1[:content] = "http://localhost:3000/reports/#{report1.id}"
    report1.save!

    # 自己の日報に言及できないことの確認
    assert_not_includes(report1.mentioning_reports, report1)
  end
end

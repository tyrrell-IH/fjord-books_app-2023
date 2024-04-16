# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    alice_report = users(:Alice).reports.create!(title: '初めまして', content: '初めての日報です')

    assert alice_report.editable?(users(:Alice))
    assert_not alice_report.editable?(users(:Bob))
  end

  test '#created_on' do
    report = users(:Alice).reports.create!(title: '初めまして', content: '初めての日報です', created_at: Date.new(2024, 4, 1))

    assert_equal Date.new(2024, 4, 1), report.created_on
  end

  test '#save_mentions' do
    report1 = users(:Alice).reports.create!(title: 'Aliceの日報サンプル', content: 'サンプルです')
    report2 = users(:Bob).reports.create!(title: 'Bobの日報サンプル', content: 'サンプルです')
    report3 = users(:Carol).reports.create!(title: 'Carolの日報サンプル', content: "http://localhost:3000/reports/#{report1.id}")

    assert_includes(report3.mentioning_reports, report1)

    report3.update!(content: "http://localhost:3000/reports/#{report2.id}
                              http://localhost:3000/reports/#{report3.id}")

    assert_not_includes(report3.reload.mentioning_reports, report1)
    assert_includes(report3.mentioning_reports, report2)
    # 自己の日報には言及できないことの確認
    assert_not_includes(report3.mentioning_reports, report3)

    report3.destroy!
    assert_nil(ReportMention.find_by(mention_to_id: report3.id))
  end
end

# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:Alice_report)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'
    fill_in 'タイトル', with: '感想'
    fill_in '内容', with: 'だんだんプラクティスに慣れてきました。'
    click_on '登録する'
    assert_text '日報が作成されました。'
    assert_text '感想'
    assert_text 'だんだんプラクティスに慣れてきました。'
  end

  test 'should create report with mention' do
    visit reports_url
    click_on '日報の新規作成'
    assert_difference 'ReportMention.count', 1 do
      fill_in 'タイトル', with: '参照した日報'
      fill_in '内容', with: "Bobさんの日報です。http://localhost:3000/reports/#{reports(:Bob_report).id}"
      click_on '登録する'
      assert_text '日報が作成されました。'
    end
    assert_text '参照した日報'
    assert_text "Bobさんの日報です。http://localhost:3000/reports/#{reports(:Bob_report).id}"
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'
    fill_in 'タイトル', with: '自己紹介と応援'
    fill_in '内容', with: 'Aliceです。Bobさんにも頑張って欲しい'
    click_on '更新する'
    assert_text '日報が更新されました。'
    assert_text '自己紹介と応援'
    assert_text 'Aliceです。Bobさんにも頑張って欲しい'
  end

  test 'should update Report add mention' do
    visit report_url(@report)
    click_on 'この日報を編集'
    assert_difference 'ReportMention.count', 1 do
      fill_in 'タイトル', with: '自己紹介と応援'
      # http://localhost:3000/reports/#{reports(:Alice_report).id}は編集中のこの日報自身なのでReportMention.countには影響しない。
      fill_in '内容', with: "Aliceです。Bobさんにも頑張って欲しい。http://localhost:3000/reports/#{reports(:Bob_report).id} http://localhost:3000/reports/#{reports(:Alice_report).id}"
      click_on '更新する'
      assert_text '日報が更新されました。'
    end
    assert_text '自己紹介と応援'
    assert_text "Aliceです。Bobさんにも頑張って欲しい。http://localhost:3000/reports/#{reports(:Bob_report).id} http://localhost:3000/reports/#{reports(:Alice_report).id}"
  end

  test 'should update Report reduce mention' do
    visit report_url(reports(:Alice_report_with_mention))
    click_on 'この日報を編集'
    assert_difference 'ReportMention.count', -1 do
      fill_in 'タイトル', with: '言及なしの日報'
      fill_in '内容', with: 'Bobの日報へ言及しないよう修正しました。'
      click_on '更新する'
      assert_text '日報が更新されました。'
    end
    assert_text '言及なしの日報'
    assert_text 'Bobの日報へ言及しないよう修正しました。'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'
    assert_text '日報が削除されました。'
    assert_no_text 'Aliceの自己紹介'
  end

  test 'should destroy Report with mention' do
    visit report_url(reports(:Alice_report_with_mention))
    assert_difference 'ReportMention.count', -1 do
      click_on 'この日報を削除'
      assert_text '日報が削除されました。'
    end
    assert_no_text '言及ありの日報'
  end
end

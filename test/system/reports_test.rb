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
      fill_in '内容', with: 'Bobさんの日報です。http://localhost:3000/reports/2'
      click_on '登録する'
    end
    assert_text '日報が作成されました。'
    assert_text '参照した日報'
    assert_text 'Bobさんの日報です。http://localhost:3000/reports/2'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: 'プラクティスの進捗'
    fill_in '内容', with: 'HTMLの課題を提出しました'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text 'プラクティスの進捗'
    assert_text 'HTMLの課題を提出しました'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
  end
end

# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:Alice_first_report)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test 'visiting the index' do
    assert_text 'ログインしました。'
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    assert_text 'ログインしました。'
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '２回目の日報です'
    fill_in '内容', with: '２回目の日報です。だんだんプラクティスに慣れてきました。'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '２回目の日報です'
    assert_text '２回目の日報です。だんだんプラクティスに慣れてきました。'
  end

  test 'should update Report' do
    assert_text 'ログインしました。'
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
    assert_text 'ログインしました。'
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました。'
  end
end

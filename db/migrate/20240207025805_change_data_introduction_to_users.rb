class ChangeDataIntroductionToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :introduction, :text
  end
end

class RemoveUserFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_reference :articles, :user, null: false, foreign_key: true
  end
end

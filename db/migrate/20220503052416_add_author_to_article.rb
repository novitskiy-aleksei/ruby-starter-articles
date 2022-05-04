class AddAuthorToArticle < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :articles, :user
  end
end

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :article
      t.text :content

      t.timestamps null: false
    end
  end
end

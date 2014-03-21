class CreatePostItems < ActiveRecord::Migration
  def change
    create_table :post_items do |t|
      t.string :name
      t.string :category
      t.string :description
      t.decimal :price

      t.timestamps
    end
  end
end

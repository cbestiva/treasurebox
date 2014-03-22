class AddImageToPostItems < ActiveRecord::Migration
  def change
    add_column :post_items, :image, :string
  end
end

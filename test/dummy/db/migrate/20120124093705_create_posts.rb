class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.boolean :is_visible

      t.timestamps
    end
  end
end

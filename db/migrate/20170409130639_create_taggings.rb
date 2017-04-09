class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.belongs_to :image
      t.belongs_to :tag
      t.timestamps null: false
    end

    remove_index :tags, name: 'index_tags_on_image_id'
    remove_column :tags, :image_id
  end
end

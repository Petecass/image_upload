class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.belongs_to :image, index: true
      t.timestamps null: false
    end
  end
end

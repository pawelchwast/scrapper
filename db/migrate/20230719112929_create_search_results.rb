class CreateSearchResults < ActiveRecord::Migration[6.1]
  def change
    create_table :search_results do |t|
      t.belongs_to :phrase, null: false, foreign_key: true
      t.integer :position
      t.string :source
      t.text :title
      t.text :link

      t.timestamps
    end
  end
end

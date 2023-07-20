class CreatePhrases < ActiveRecord::Migration[6.1]
  def change
    create_table :phrases do |t|
      t.string :name
      t.string :hl
      t.string :gl
      t.string :google_domain
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end

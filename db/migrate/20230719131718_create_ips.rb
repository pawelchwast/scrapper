class CreateIps < ActiveRecord::Migration[6.1]
  def change
    create_table :ips do |t|
      t.belongs_to :search_result, null: false, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end

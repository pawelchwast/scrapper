class CreateDeletedDomains < ActiveRecord::Migration[6.1]
  def change
    create_table :deleted_domains do |t|
      t.string :fqdn
      t.date :date

      t.timestamps
    end
  end
end

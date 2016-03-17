class CreateOsakanas < ActiveRecord::Migration
  def change
    create_table :osakanas do |t|
      t.string :name, limit: 64
      t.string :information, limit: 4096
      t.string :map, limit: 4096
      t.string :ecology, limit: 1024
      t.string :food, limit: 1024
      t.string :extra, limit: 4096

      t.timestamps null: false
    end
  end
end

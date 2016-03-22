class OsakanasNameUniq < ActiveRecord::Migration
  def change
    add_index :osakanas, :name, :unique => true
  end
end

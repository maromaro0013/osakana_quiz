class OsakanasAddUrl < ActiveRecord::Migration
  def change
    add_column :osakanas, :url, :string, limit: 1024
  end
end

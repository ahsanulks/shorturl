class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string      :url
      t.string      :shorten
      t.timestamps  null: false
    end

    add_index :urls, :shorten
  end
end

class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.references :actor
      t.text :data
      t.datetime :github_created_at, null: false

      t.timestamps
    end
  end
end

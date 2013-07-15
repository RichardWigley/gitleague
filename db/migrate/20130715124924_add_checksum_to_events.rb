class AddChecksumToEvents < ActiveRecord::Migration
  def change
    add_column :events, :checksum, :string, null: false, uniq: true
  end
end

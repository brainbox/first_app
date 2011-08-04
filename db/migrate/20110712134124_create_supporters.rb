class CreateSupporters < ActiveRecord::Migration
  def self.up
    create_table :supporters do |t|
      t.integer :language_id
      t.string :country_code

      t.timestamps
    end
  end

  def self.down
    drop_table :supporters
  end
end

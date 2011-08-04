class CreateLetters < ActiveRecord::Migration
  def self.up
    create_table :letters do |t|
      t.integer :letter_campaign_id
      t.integer :language_id
      t.integer :supporter_id
      t.string :country_code

      t.timestamps
    end
  end

  def self.down
    drop_table :letters
  end
end

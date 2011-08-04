class CreateLetterCampaigns < ActiveRecord::Migration
  def self.up
    create_table :letter_campaigns do |t|
      t.string :name
      t.string :slug
	  t.integer :language_id

      t.timestamps
    end
  end

  def self.down
    drop_table :letter_campaigns
  end
end

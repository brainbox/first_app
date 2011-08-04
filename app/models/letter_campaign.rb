class LetterCampaign < ActiveRecord::Base
  
  has_many :letters

  
  def self.tribe_total_on(tribe, date)
    #where("date(created_at) = ?", date).count
    find(:all,:conditions => ["date(created_at) = ? AND name = ?", date, tribe]).count
  
	end

  def self.get_total_letters_for_campaign_by_dates(options)
  # options[:end_date] = ((options[:end_date]).to_date + 1.day).to_date.strftime('%Y-%m-%d')
    options[:end_date] += 1.day # Had to include the one day to accomodate dates like 2011-06-05 01:02:03
    total = 0
    #campaigns = self.where(['name=?', options[:campaign_name]])
	campaigns = find(:all,:conditions => ['name=?', options[:campaign_name]])
	campaigns.each do |campaign|
	  result = Letter.find(:all,:conditions => ["letter_campaign_id=? and (created_at) between ? and ?", campaign.id, options[:start_date].to_date.strftime('%Y-%m-%d'), options[:end_date].to_date.strftime('%Y-%m-%d')]).count  
	  total += result
	 
	end
	return total
  end
  
  def self.get_all_campaign_names
	campaigns = Array.new
	self.find(:all).each do |campaign|
		campaigns.push campaign.name unless campaigns.include?(campaign.name)
	end
	return campaigns.sort
 end
end
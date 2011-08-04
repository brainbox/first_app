class Language < ActiveRecord::Base
  
  has_many :letters

 def self.lang_total_on(lang, date)
    #where("date(created_at) = ?", date).count
    find(:all,:conditions => ["date(created_at) = ? AND lang_name = ?", date, lang]).count
  end
  
 end 
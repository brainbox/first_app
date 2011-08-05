class LetterCampaignsController < ApplicationController
before_filter :ensure_is_signed_in
  # GET /letter_campaigns
  # GET /letter_campaigns.xml
  
  def index
    @campaigns = LetterCampaign.get_all_campaign_names
	@max_number_of_tribes = 4
	@params = params
	@interval = params[:interval].nil? ? 7 : params[:interval].to_i
	@first = params[:first]
	@last = params[:last]

	# Check provided parameters exist
    if @interval <= 0
      flash.now[:notice] = "You must specify a positive interval"
    end

	# If dates exist, extract the date string and check it's sensible before creating as Date object
    if @first
	  @first = @first.match(/\d{4}-[01]\d-[0-3]\d/)
	  if @first.nil?
	    flash.now[:notice] = "Invalid start date."
	  else
        @first = Time.parse(@first.string)
	  end
	end
	if @last
	  @last = @last.match(/\d{4}-[01]\d-[0-3]\d/)
	  if @last.nil?
	    flash.now[:notice] = "Invalid end date."
	  else
        @last = Time.parse(@last.string)
	  end
	end

	# Check passed dates are sensible
	if @first && @last && flash.empty?
      if @first == @last
        flash.now[:notice] = "You can not select the same date"
      elsif @first > @last
	    flash.now[:notice] = "End date must be after start date"
      end
	end
	  
	# If no errors with parameters
	if @first && flash.empty?
      @letter_campaigns = LetterCampaign.all
            
	  names = Array.new
	  (0..@max_number_of_tribes).each do |num|
		names.push params["campaign#{num}"] unless params["campaign#{num}"].eql?('0')
	  end
      @series = {}
      names.each do |name|
	    series_data = Array.new
	    (@first.to_i..@last.to_i).step(@interval.days).each do |date|
		  date = Time.at(date)
		  series_data.push LetterCampaign.get_total_letters_for_campaign_by_dates(:start_date=>date, :end_date=>date+@interval.days, :campaign_name=>name)
		  end
        @series[name] = series_data.inspect
      end
	end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @letter_campaigns }
    end
  end
end

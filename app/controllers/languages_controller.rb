class LanguagesController < ApplicationController
before_filter :ensure_is_signed_in
 
  # GET /languages
  # GET /languages.xml
   def index
      @first = params[:first]
	  @last = params[:last]
	  @params = params
	  @interval = params[:interval].nil? ? 7 : params[:interval].to_i
	  
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
      @languages = Language.all
      
      @series = {}
      @languages.each do |language|
	    series_data = Array.new
	    (@first.to_i..@last.to_i).step(@interval.days).each do |date|
		  date = Time.at(date)
		  series_data.push language.letters.lang_total_on(language.id, date, (date+@interval.days))
		end
        @series[language.lang_name] = series_data.inspect
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @languages }
    end
  end

end

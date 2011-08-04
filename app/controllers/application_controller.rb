class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #protect_from_forgery
  include SessionsHelper
    def ensure_is_signed_in
    if current_user.nil? && !Rails.env.test?
      redirect_to(root_url, :notice => 'You must be logged in.')
	  return false
    end
  end
end

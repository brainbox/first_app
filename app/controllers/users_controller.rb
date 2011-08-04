class UsersController < ApplicationController
   def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  
  

  # POST /users
  # POST /users.xml
  

  
  
end

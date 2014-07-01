class UsersController < ApplicationController
  def show
	#if (signed_in?)
		@user = User.find(params[:id])
	#else
	#	flash[:error]="You must sign in to see this information"
	#	redirect_to signin_path
	#end
  end
  
  def new
	@user = User.new
  end
  
   def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
	  sign_in @user
	  flash[:success] = "Welcome to the Sample App!"
	  
      redirect_to @user
    else
      render 'new'
    end
  end
  
   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
  
end

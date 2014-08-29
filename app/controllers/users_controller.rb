class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def show
	#if (signed_in?)
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
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
  
  
  def edit
	@user = User.find(params[:id])
  end
  
  def update 
	@user = User.find(params[:id])
	if @user.update_attributes(user_params)
		flash[:success] = "Profile updated"
		redirect_to @user
	else
		render 'edit'
	end
  end
  
  def index 
	@users = User.paginate(page: params[:page], per_page: 30, :conditions => ['name like ?', "%#{params[:search]}%"])
  end
  
  def destroy
	user = User.find(params[:id])
	if user != current_user 
		user.delete
		flash[:success] = "Successfully deleted"
		redirect_to users_url
	else 
		redirect_to root_url
	end
  end
  
  def following 
	@title = "Following" 
	@user = User.find(params[:id])
	@users = @user.followed_users.paginate(page: params[:page])
	render 'show_follow'
  end
  
  def followers
	@title = "Followers"
	@user = User.find(params[:id])
	@users = @user.followers.paginate(page: params[:page])
	render 'show_follow'
  end
  
  
   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
	
	
	#Before filters
	

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end
  
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
	
end

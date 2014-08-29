class RelationshipsController < ApplicationController
	before_action :signed_in_user
	def create
		@user = User.find_by(id: params[:relationship][:followed_id])
		current_user.follow!(@user)
		
		respond_to do |format|
			format.html { redirect_to @user }
			format.js 
		end
	end
	
	def destroy
		
		@user = Relationship.find(params[:id]).followed
	    current_user.unfollow!(@user)
		
		respond_to do |format|
			format.html { redirect_to @user }
			format.js 
		end
		
	end
	
	private
	
		def prot
			
			@user = User.find_by(id: params[:relationship][:followed_id])
			
			if !current_user || !@user || current_user == @user
				flash['error'] = "Error while follow"
				redirect_to root_path
			end
			
		end
end
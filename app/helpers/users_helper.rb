module UsersHelper

  def gravatar_for(user, params={})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{params[:size]}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  def img_helper(url)
	if !url.empty?
		image_tag(url, alt: "Image")
	end
  end
end
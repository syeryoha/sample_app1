class User < ActiveRecord::Base
	before_save do
		self.email = email.downcase
	end
	
	validates :name, presence: true, length: {maximum: 50, minimum: 5} 
	VALID_EMAIL_REGEX = /\A[\w]+([\-\.\D]\w+)*@[a-zA-Z0-9]+([\-\.][a-zA-Z0-9]+)*\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
	
	
	
	has_secure_password
	validates :password, length: { minimum: 6 }
end

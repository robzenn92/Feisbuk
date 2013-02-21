class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation, :posts

  include Gravtastic
	before_validation :prep_email

  validates :username, :email, :password_digest, :presence => true 
  validates :username, :uniqueness => true, :length => { minimum: 3, maximum: 18 }
  validates :email, :uniqueness => true, :format => { with: /^[\w.+-]+@([\w]+.)+\w+$/ }

  has_secure_password
  has_gravatar :secure => true, :filetype => :png, :size => 120

  has_many :posts

  private

    def prep_email
        self.email = self.email.strip.downcase if self.email
    end
end
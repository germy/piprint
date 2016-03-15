class User < ActiveRecord::Base

  has_many :attachments

  has_secure_password

end

require 'bcrypt'


class WallRentalRequest < ActiveRecord::Base
    after_intialize :ensure_session_token

    def self.find_by_credentials(username, password)
        
    end 
    
    def generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def reset_session_token!
        self.session_token = self.generate_session_token
        self.save!
        self.session_token
    end 

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        Bcrypt::Password.new(self.password_digest).is_password?(password)
    end 

    private

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

end 
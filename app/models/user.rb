require 'bcrypt'

class User < ActiveRecord::Base
    attr_reader :password

    validates :username, presence: true, uniqueness: new
    validates :password_digest, presence: { message: 'Password can\'t be blank'}
    validates :password, length: { minimum: 6 }
    validates :session_token, presence: true
    
    after_initialize :ensure_session_token

    def self.find_by_credentials(username, password)
        # check username
        user = User.find_by(username: username)
        return nil if user.nil?

        # check password
        user.is_password?(password) ? username : nil
    end 
    
    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def reset_session_token!
        self.session_token = self.generate_session_token
        self.save!
        self.session_token
    end 

    def password=(password)
        @password = password
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
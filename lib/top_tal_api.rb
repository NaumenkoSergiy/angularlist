module TopTalApi

  TOKEN_EXPIRATION_TIME = 2.hours

  def self.find_user_by token
    user = User.joins(:access_token).where('access_tokens.token = ?', token).first
    if user && user.access_token.created_at < Time.now - TOKEN_EXPIRATION_TIME
      user.access_token.destroy
      return nil
    end
    user
  end

  class Client
    attr_accessor :email, :password

    def initialize(email, password)
      @email    = email
      @password = password
    end

    def authenticate!
      return false unless user
      if user.valid_password?(password)
        regenerate_token
      else
        false
      end
    end

    def access_token
      user.access_token.token
    end

    private

    def user
      @user ||= User.find_by(email: email)
    end

    def regenerate_token
      user.access_token.destroy if user.access_token
      user.access_token = AccessToken.create(token: SecureRandom.urlsafe_base64)
    end
  end
end

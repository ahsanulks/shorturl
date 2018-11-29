module UserService
  class Create < Services::Base
    Contract String, String, String => C::Any
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
    end

    def perform
      return Services::InvalidShortenError.new if User.exists?(email: @email)

      user          = User.new
      user.name     = @name
      user.email    = @email
      user.password = @password
      user
    end
  end
end

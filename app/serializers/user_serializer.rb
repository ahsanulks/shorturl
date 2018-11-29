class UrlSerializer
  def initialize(user)
    @user = user
  end

  def as_json(*)
    data = {
      name: @user.name,
      email: @user.email
    }
  end
end

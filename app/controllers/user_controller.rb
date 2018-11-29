class UserController < ApplicationController

  post('/') do
    user = UserService.create(json_params['name'], json_params['email'], json_params['password'])
    if user.is_a?(User)
      user.save
      status 201
      render_serializer(User, 'UserSerializer')
    else
      status 422
      body respond_status(url.message)
    end
  end
end

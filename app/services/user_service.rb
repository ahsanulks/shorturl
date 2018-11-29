module UserService
  module_function

  def create(*args)
    UserService::Create.new(*args).call
  end
end

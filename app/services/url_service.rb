module UrlService
  module_function

  def create(*args)
    UrlService::Create.new(*args).call
  end
end

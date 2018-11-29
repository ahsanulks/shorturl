require 'contracts'

module Services
  class Base
    extend ActiveModel::Callbacks
    include Contracts::Core

    C = Contracts

    define_model_callbacks :perform

    def call
      run_callbacks :perform do
        perform
      end
    end

    def perform
      raise NotImplementedError
    end
  end

  class ServiceError < StandardError; end

  class InvalidShortenError < ServiceError
    def initialize(msg = 'Short URL already exists')
      super
    end
  end

  class EmailAlreadyExists < ServiceError
    def initialize(msg = 'Email address already exists')
      super
    end
  end
end

module UrlService
  class Create < Services::Base
    Contract String, C::Or[String, nil] => C::Any
    def initialize(url, shorten)
      @url = url
      @shorten = shorten.presence || generate_shorten
    end

    def perform
      return Services::InvalidShortenError.new if Url.exists?(shorten: @shorten)

      url         = Url.new
      url.url     = @url
      url.shorten = @shorten
      url
    end

    private

    def generate_shorten
      begin
        range = [*'0'..'9',*'A'..'Z',*'a'..'z']
        shorten = Array.new(6){ range.sample }.join
      end while Url.exists?(shorten: shorten)
      shorten
    end
  end
end

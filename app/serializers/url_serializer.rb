class UrlSerializer
  def initialize(url)
    @url = url
  end

  def as_json(*)
    data = {
      url: @url.url,
      shorten: @url.shorten
    }
  end
end

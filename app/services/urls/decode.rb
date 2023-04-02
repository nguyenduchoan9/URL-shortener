module Urls
  class Decode < BaseService
    attr_reader :url

    def initialize(short_url)
      @short_url = short_url
    end

    def call
      @url = Url.find_by(short_url: @short_url)
      add_error("The shortened URL does not exist") if @url.nil?
    end
  end
end
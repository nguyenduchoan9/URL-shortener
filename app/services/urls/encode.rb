module Urls
  class Encode < BaseService
    attr_reader :url

    def initialize(original_url)
      @original_url = original_url
    end

    def call
      @url = Url.find_by(original_url: @original_url)
      return if @url

      generate_short_url_service = GenerateShortUrl.new(@original_url)
      generate_short_url_service.call
      if generate_short_url_service.error?
        add_errors(generate_short_url_service.errors)
        return
      end

      @url = Url.create!(
        original_url: @original_url,
        short_url: generate_short_url_service.short_url
      )
    rescue StandardError => e
      add_error(e)
    end
  end
end
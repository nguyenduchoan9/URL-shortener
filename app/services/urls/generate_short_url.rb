module Urls
  class GenerateShortUrl < BaseService
    SCHEME_HTTP = 'http'.freeze
    SCHEME_HTTPS = 'https'.freeze

    attr_reader :short_url

    def initialize(original_url)
      @original_url = original_url
    end

    def call
      original_uri = URI.parse(@original_url)
      if  ![SCHEME_HTTP, SCHEME_HTTPS].include?(original_uri.scheme)
        add_error("Unsupported URL")
        return
      end

      uuid = Druuid.gen
      short_path = Base62.encode(uuid)
      short_url_params = {
        host: original_uri.host,
        path: "/#{short_path}"
      }
      @short_url = if original_uri.scheme == SCHEME_HTTP
                     URI::HTTP.build(short_url_params)
                   else
                     URI::HTTPS.build(short_url_params)
                   end
    end
  end
end
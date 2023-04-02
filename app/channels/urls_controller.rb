class UrlsController < ApplicationController
  def encode
    service = Urls::Encode.new(params[:url])
    service.call

    return render json: { message: service.error_messages }, status: :unprocessable_entity if service.error?

    render json: { short_url: service.url.short_url }
  end

  def decode
    service = Urls::Decode.new(params[:url])
    service.call

    return render json: { message: service.error_messages }, status: :unprocessable_entity if service.error?

    render json: { original_url: service.url.original_url }
  end
end
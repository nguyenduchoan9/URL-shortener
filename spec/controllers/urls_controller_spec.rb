require 'rails_helper'

RSpec.describe ::UrlsController, type: :controller do
  describe "#encode" do
    describe "successfully" do
      let!(:url) { create(:url) }
      let(:encode_url_service) {
        double(
          ::Urls::Encode.name,
          call: nil,
          success?: true,
          error?: false,
          error_messages: [],
          url: url
        )
      }

      before do
        expect(Urls::Encode).to receive(:new).with(url.original_url).and_return(encode_url_service)
        post :encode, params: { url: url.original_url }
      end

      it do
        expect(response.status).to eq(200)
        expect(response_body['short_url']).to eq(url.short_url)
      end
    end

    describe "failed" do
      let(:url) { "https://google.com" }
      let(:encode_url_service) {
        double(
          ::Urls::Encode.name,
          call: nil,
          success?: false,
          error?: true,
          error_messages: ["Unsupported URL"]
        )
      }

      before do
        expect(Urls::Encode).to receive(:new).with(url).and_return(encode_url_service)
        post :encode, params: { url: url }
      end

      it do
        expect(response.status).to eq(422)
        expect(response_body['message']).to eq(["Unsupported URL"])
      end
    end
  end

  describe "#decode" do
    describe "successfully" do
      let!(:url) { create(:url) }
      let(:decode_url_service) {
        double(
          ::Urls::Decode.name,
          call: nil,
          success?: true,
          error?: false,
          error_messages: [],
          url: url
        )
      }

      before do
        expect(Urls::Decode).to receive(:new).with(url.short_url).and_return(decode_url_service)
        post :decode, params: { url: url.short_url }
      end

      it do
        expect(response.status).to eq(200)
        expect(response_body['original_url']).to eq(url.original_url)
      end
    end

    describe "failed" do
      let(:short_url) { 'https://non-exist.com' }
      let(:decode_url_service) {
        double(
          ::Urls::Decode.name,
          call: nil,
          success?: false,
          error?: true,
          error_messages: ["The shortened URL does not exist"]
        )
      }

      before do
        expect(Urls::Decode).to receive(:new).with(short_url).and_return(decode_url_service)
        post :decode, params: { url: short_url }
      end

      it do
        expect(response.status).to eq(422)
        expect(response_body['message']).to eq(["The shortened URL does not exist"])
      end
    end
  end
end
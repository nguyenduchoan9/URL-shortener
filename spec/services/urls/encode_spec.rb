require 'rails_helper'

RSpec.describe ::Urls::Encode do
  describe "shorten URL does not exist" do
    let(:original_url) { 'https://google.com/long-path' }
    let(:short_url) { 'https://google.com/short-path' }
    let(:service) { described_class.new(original_url) }
    let(:generate_short_url_service) {
      double(
        ::Urls::GenerateShortUrl.name,
        call: nil,
        success?: true,
        error?: false,
        error_messages: [],
        short_url: short_url
      )
    }

    before do
      allow(::Urls::GenerateShortUrl).to receive(:new).with(original_url).and_return(generate_short_url_service)
      service.call
    end

    it do
      expect(service.success?).to be_truthy
      expect(service.url.short_url).to eq(short_url)
    end
  end

  describe "shorten URL exist" do
    let!(:url) { create(:url) }
    let(:service) { described_class.new(url.original_url) }

    before do
      service.call
    end

    it do
      expect(service.success?).to be_truthy
      expect(service.url.short_url).to eq(url.short_url)
    end
  end
end

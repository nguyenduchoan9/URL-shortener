require 'rails_helper'

RSpec.describe ::Urls::Decode do
  describe 'shorten URL does not exist' do
    let(:short_url) { 'https://google.com/short-path' }
    let(:service) { described_class.new(short_url) }


    before do
      service.call
    end

    it do
      expect(service.success?).to be_falsey
      expect(service.url).to be_nil
    end
  end

  describe 'shorten URL does not exist' do
    let!(:url) { create(:url) }
    let(:service) { described_class.new(url.short_url) }

    before do
      service.call
    end

    it do
      expect(service.success?).to be_truthy
      expect(service.url.original_url).to eq(url.original_url)
    end
  end
end

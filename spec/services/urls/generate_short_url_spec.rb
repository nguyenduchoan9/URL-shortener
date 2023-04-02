require 'rails_helper'

RSpec.describe ::Urls::GenerateShortUrl do
  describe "#call" do
    describe 'Unsupported URL' do
      let(:unsupported_url) { 'invalid-url' }
      let(:service) { described_class.new(unsupported_url) }

      before do
        service.call
      end

      it do
        expect(service.error?).to be_truthy
        expect(service.error_messages).to eq(["Unsupported URL"])
      end
    end

    describe 'http url' do
      let(:url) { 'http://localhost.com' }
      let(:service) { described_class.new(url) }

      before do
        service.call
      end

      it do
        expect(service.success?).to be_truthy
        expect(service.short_url).to be_present
      end
    end

    describe 'https url' do
      let(:url) { 'https://localhost.com' }
      let(:service) { described_class.new(url) }

      before do
        service.call
      end

      it do
        expect(service.success?).to be_truthy
        expect(service.short_url).to be_present
      end
    end
  end
end
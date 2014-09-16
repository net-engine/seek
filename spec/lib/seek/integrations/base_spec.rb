require 'spec_helper'

RSpec.describe Seek::Integrations::Base do
  let(:token)          { 'token123' }
  let(:webservice_url) { 'webservice.example.com' }

  before do
    expect_any_instance_of(described_class).to receive(:authenticator_webservice_url).and_return(webservice_url)
    expect(HTTParty).to receive(:get).with(webservice_url).and_return('string' => token)
  end

  describe '#encrypted_access_token' do
    it 'returns the encrypted access token' do
      expect(subject.encrypted_access_token).to eql(token)
    end
  end
end

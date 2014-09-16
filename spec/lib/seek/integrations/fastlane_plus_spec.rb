require 'spec_helper'

RSpec.describe Seek::Integrations::FastlanePlus do
  username         = 'seek_username'
  username         = 'seek_username'
  password         = 'secret1234'
  role             = 'Uploader'
  uploader_id      = 111
  client_id        = 222
  test_environment = true

  subject { described_class.new username: username, password: password, role: role,
    uploader_id: uploader_id, client_id: client_id, test_environment: test_environment }

  before do
    allow_any_instance_of(Savon::Client).to receive_messages(call: nil)
    allow(HTTParty).to receive_messages(get: { 'string' => 'token123' })
  end

  describe '#new' do
    expected_instance_variables = {
      username:         username,
      password:         password,
      role:             role,
      uploader_id:      uploader_id,
      client_id:        client_id,
      test_environment: test_environment
    }

    expected_instance_variables.each do |variable_name, value|
      it "assigns @#{variable_name} instance variable" do
        expect(subject.instance_variable_get("@#{variable_name}")).to eql(value)
      end
    end
  end

  describe '#send_jobs' do
    let(:token) { 'token123' }
    let(:authenticator_webservice_url) { "http://webservices.seek.com.au/WebserviceAuthenticator.asmx/AuthenticateWS?userName=#{username}&password=#{password}&role=#{role}" }

    context 'when all jobs are valid' do
      it 'uses an authenticator webservice url with custom params' do
        expect(HTTParty).to receive(:get).with(authenticator_webservice_url).and_return({ 'string' => token })
        subject.send_jobs([])
      end

      it 'calls the upload_file action building the correct XML' do
        job = create_valid_job(all_attributes: true)

        xml = File.read File.expand_path('../../../../fixtures/fastlane_plus_envelope.xml', __FILE__)
        expect_any_instance_of(Savon::Client).to receive(:call).with(:upload_file, xml: xml).and_return(nil)

        subject.send_jobs([job])
      end
    end

    context 'when some job is not valid' do
      it 'raises an excpection' do
        job_1 = double valid?: true
        job_2 = double valid?: false

        expect { subject.send_jobs([job_1, job_2]) }.to raise_error('One or more jobs are invalid')
      end
    end
  end
end

module Seek
  module Integrations
    class FastlanePlus < Seek::Integrations::Base
      def initialize(username:, password:, role:, uploader_id:, client_id:, test_environment: false)
        @username         = username
        @password         = password
        @role             = role
        @uploader_id      = uploader_id
        @client_id        = client_id
        @test_environment = test_environment
      end

      def send_jobs(jobs)
        raise 'One or more jobs are invalid' if jobs.any? { |job| !job.valid? }

        call :upload_file, xml: build_envelope(jobs)
      end

      private

      def build_envelope(jobs)
        Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
          xml.send 'soap:Envelope',
            'xmlns:xsi'  => 'http://www.w3.org/2001/XMLSchema-instance',
            'xmlns:xsd'  => 'http://www.w3.org/2001/XMLSchema',
            'xmlns:soap' => 'http://schemas.xmlsoap.org/soap/envelope/' do

            xml.send 'soap:Body' do
              xml.send 'UploadFile', xmlns: 'http://webservices.seek.com.au' do
                xml.send 'Token', encrypted_access_token

                xml.send 'xmlFastlaneFile' do
                  xml.send 'FastLanePlus', 'UploaderID' => @uploader_id, 'AgentID' => '', 'Version' => '3.0' do
                    xml.send 'Client', 'ID' => @client_id, 'MinJobs' => '0', 'MaxJobs' => '9999999' do
                      xml << jobs.map(&:to_xml).join("\n")
                    end
                  end
                end
              end
            end
          end
        end.to_xml
      end

      def call(action, options)
        @client ||= Seek::Adapters::SoapClient.new(wsdl_url, test_environment: @test_environment)
        @client.call(action, options)
      end

      def wsdl_url
        "http://#{@test_environment ? 'test.' : ''}webservices.seek.com.au/FastLanePlus.asmx?WSDL"
      end
    end
  end
end

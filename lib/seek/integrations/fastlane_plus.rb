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
        call :upload_file, xml: build_envelope
      end

      private

      def build_envelope
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
                      xml << jobs.join("\n")
                    end
                  end
                end
              end
            end
          end
        end.to_xml
      end

      def jobs
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.send 'Job', 'Reference' => 'TEST1', 'TemplateID' => '', 'ScreenID' => '' do
            xml.send 'Title',       'Test Job Ad – Please Do Not Apply'
            xml.send 'SearchTitle', 'Test Job Ad – Please Do Not Apply'
            xml.send 'Description', 'Test Job Ad – Please Do Not Apply'

            xml.send 'AdDetails' do
              xml.cdata('<br \>test <b>This line is bold</b>')
            end

            xml.send 'ApplicationEmail', 'person@xyzcompany.com.au'
            xml.send 'ApplicationURL', ''
            xml.send 'ResidentsOnly', 'Yes'

            xml.send 'Items' do
              xml.send 'Item', 'Test Job Ad – Please Do Not Apply', 'Name' => 'Jobtitle'
              xml.send 'Item', '-',                                 'Name' => 'Bullet1'
              xml.send 'Item', '-',                                 'Name' => 'Bullet2'
              xml.send 'Item', '-',                                 'Name' => 'Bullet3'
              xml.send 'Item', '-',                                 'Name' => 'ContactName'
              xml.send 'Item', '-',                                 'Name' => 'PhoneNo'
              xml.send 'Item', '-',                                 'Name' => 'FaxNo'
              xml.send 'Item', 'SK/CC1234',                         'Name' => 'RefNumber'
            end

            xml.send 'Listing', 'MarketSegments' => 'Main Campus' do
              xml.send 'Classification', 'Sydney',                     'Name' => 'Location'
              xml.send 'Classification', 'CBDInnerWestEasternSuburbs', 'Name' => 'Area'
              xml.send 'Classification', 'FullTime',                   'Name' => 'WorkType'
              xml.send 'Classification', 'DesignArchitecture',         'Name' => 'Classification'
              xml.send 'Classification', 'Architecture',               'Name' => 'SubClassification'
            end

            xml.send 'Salary', 'Type' => 'AnnualPackage', 'Min' => '50000', 'Max' => '69999', 'AdditionalText' => ''
            xml.send 'StandOut', 'IsStandOut' => 'false', 'LogoID' => '', 'Bullet1' => '', 'Bullet2' => '', 'Bullet3' => ''
          end
        end

        [Nokogiri::XML(builder.to_xml).root.to_xml]
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

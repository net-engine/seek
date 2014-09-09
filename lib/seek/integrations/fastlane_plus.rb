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

      def build_envelope
        xml_content = <<-XML
          <?xml version="1.0" encoding="utf-8"?>
          <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
            <soap:Body>
              <UploadFile xmlns="http://webservices.seek.com.au">
                <Token>#{encrypted_access_token}</Token>

                <xmlFastlaneFile>
                  <FastLanePlus UploaderID="#{@uploader_id}" AgentID="" Version="3.0">
                    <Client ID="#{@client_id}" MinJobs="0" MaxJobs="9999999">
                      #{jobs.join("\n")}
                    </Client>
                  </FastLanePlus>
                </xmlFastlaneFile>
              </UploadFile>
            </soap:Body>
          </soap:Envelope>
        XML

        xml_content.strip
      end

      def jobs
        job_content = <<-JOB
        <Job Reference="TEST1" TemplateID="" ScreenID="">
          <Title>Test Job Ad – Please Do Not Apply</Title>
          <SearchTitle>Test Job Ad – Please Do Not Apply</SearchTitle>
          <Description>Test Job Ad – Please Do Not Apply</Description>
          <AdDetails><![CDATA[\<br\>test \<b\>This line is bold\</b\>]]></AdDetails>
          <ApplicationEmail>person@xyzcompany.com.au</ApplicationEmail>
          <ApplicationURL></ApplicationURL>
          <ResidentsOnly>Yes</ResidentsOnly>
          <Items>
            <Item Name="Jobtitle">Graduate Architect (test)</Item>
            <Item Name="Bullet1">-</Item>
            <Item Name="Bullet2">-</Item>
            <Item Name="Bullet3">-</Item>
            <Item Name="ContactName">-</Item>
            <Item Name="PhoneNo">-</Item>
            <Item Name="FaxNo">-</Item>
            <Item Name="RefNumber">SK/CC1234</Item>
          </Items>
          <Listing MarketSegments="Main Campus">
            <Classification Name="Location">Sydney</Classification>
            <Classification Name="Area">CBDInnerWestEasternSuburbs</Classification>
            <Classification Name="WorkType">FullTime</Classification>
            <Classification Name="Classification">DesignArchitecture</Classification>
            <Classification Name="SubClassification">Architecture</Classification>
          </Listing>
          <Salary Type="AnnualPackage" Min="50000" Max="69999" AdditionalText="" />
          <StandOut IsStandOut="false" LogoID="" Bullet1="" Bullet2="" Bullet3="" />
        </Job>
        JOB

        [job_content.strip]
      end

      private

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

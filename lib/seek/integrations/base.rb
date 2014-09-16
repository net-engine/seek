module Seek
  module Integrations
    class Base
      def encrypted_access_token
        HTTParty.get(authenticator_webservice_url)['string']
      end

      private

      def authenticator_webservice_url
        "http://webservices.seek.com.au/WebserviceAuthenticator.asmx/AuthenticateWS?userName=#{@username}&password=#{@password}&role=#{@role}"
      end
    end
  end
end

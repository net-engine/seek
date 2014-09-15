module Seek
  module Adapters
    class SoapClient
      def initialize(wsdl, test_environment:)
        @client = Savon.client({
          wsdl: wsdl,
          pretty_print_xml: test_environment,
          log: true
          # soap_version: 2, # SOAP 1.2
          # env_namespace: 'soap',
          # namespace_identifier: '',
          # element_form_default: :unqualified,
          # strip_namespaces: false
        })
      end

      def call(action, options)
        @client.call(action, options)
      end
    end
  end
end

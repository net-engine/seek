require 'spec_helper'

RSpec.describe Seek::Adapters::SoapClient do
  subject { described_class.new('wsdl.example.com', test_environment: true) }

  describe '#new' do
    expected_instance_variables = {
      client: Savon::Client
    }

    expected_instance_variables.each do |variable_name, value|
      it "assigns @#{variable_name} instance variable" do
        expect(subject.instance_variable_get("@#{variable_name}")).to be_a(value)
      end
    end
  end

  describe '#call' do
    it 'delegates the call method to client instance' do
      expect(subject.instance_variable_get('@client')).to receive(:call).with(:foobar, foo: :bar)

      subject.call(:foobar, foo: :bar)
    end
  end
end

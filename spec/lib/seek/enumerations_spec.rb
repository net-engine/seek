require 'spec_helper'

RSpec.describe Seek::Enumerations do
  context 'dynamic methods' do
    Dir["#{File.expand_path('..', __FILE__)}/../../../lib/seek/enumerations/*.yml"].each do |file|
      method_name = File.basename(file, '.yml').to_sym

      describe "##{method_name}" do
        it 'returns a non-empty array' do
          expect(described_class.send(method_name).size).to be > 0
        end
      end
    end
  end
end

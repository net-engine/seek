require 'spec_helper'

RSpec.describe Seek::SalaryRanges do
  describe '.available_values' do
    it 'returns a non-empty array' do
      expect(described_class.available_values.size).to be > 1
    end
  end

  describe '.available_max_values' do
    it 'returns the correct array' do
      expect(described_class.available_max_values(0)).to     eql([19999, 24999, 29999, 34999, 39999])
      expect(described_class.available_max_values(60000)).to eql([64999, 69999, 74999, 79999])
    end
  end
end

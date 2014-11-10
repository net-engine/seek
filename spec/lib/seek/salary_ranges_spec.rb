require 'spec_helper'

RSpec.describe Seek::SalaryRanges do
  describe '.available_values' do
    it 'returns a non-empty array' do
      expect(described_class.available_values.size).to be > 1
    end
  end

  describe '.hourly_rate_values' do
    it 'returns a non-empty array' do
      expect(described_class.hourly_rate_values.size).to be > 1
    end
  end

  describe '.available_max_values' do
    it 'returns the correct array' do
      expect(described_class.available_max_values(0)).to     eql([19999, 24999, 29999, 34999, 39999])
      expect(described_class.available_max_values(60000)).to eql([64999, 69999, 74999, 79999])
    end
  end

  describe '.hourly_rate_max_values' do
    it 'returns the correct array' do
      expect(described_class.hourly_rate_max_values(0)).to  eql([9.99, 14.99, 19.99])
      expect(described_class.hourly_rate_max_values(50)).to eql([54.99, 59.99, 64.99, 69.99, 74.99])
    end
  end
end

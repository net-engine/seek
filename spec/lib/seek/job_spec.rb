require 'spec_helper'

RSpec.describe Seek::Job do
  it 'assigns instance variables' do
    attribute_1, attribute_2 = described_class::REQUIRED_ATTRIBUTES.sample(2)
    attribute_3, attribute_4 = described_class::NOT_REQUIRED_ATTRIBUTES.sample(2)

    subject = described_class.new(attribute_1 => 'A', attribute_2 => 'B')

    subject.send("#{attribute_3}=", 'C')
    subject.send("#{attribute_4}=", 'D')

    expect(subject.send(attribute_1)).to eql('A')
    expect(subject.send(attribute_2)).to eql('B')
    expect(subject.send(attribute_3)).to eql('C')
    expect(subject.send(attribute_4)).to eql('D')
  end

  describe '#valid?' do
    subject { create_valid_job(all_attributes: true) }

    context 'when it has all required attributes' do
      it 'returns true' do
        expect(subject).to be_valid
      end
    end

    context 'when it does not have all required attributes' do
      it 'returns false' do
        required_attribute = described_class::REQUIRED_ATTRIBUTES.sample
        subject.send("#{required_attribute}=", nil)

        expect(subject).to_not be_valid
      end
    end
  end

  describe '#to_xml' do
    subject { create_valid_job(all_attributes: true) }

    it 'generates the XML' do
      xml = File.read File.expand_path('../../../fixtures/job.xml', __FILE__)

      expect(subject.to_xml).to eql(xml.strip)
    end
  end
end

require 'spec_helper'

RSpec.describe Seek::Job do
  it 'assigns instance variables' do
    attribute_1, attribute_2 = Seek::Job::REQUIRED_ATTRIBUTES.sample(2)
    attribute_3, attribute_4 = Seek::Job::NOT_REQUIRED_ATTRIBUTES.sample(2)

    subject = described_class.new(attribute_1 => 'A', attribute_2 => 'B')

    subject.send("#{attribute_3}=", 'C')
    subject.send("#{attribute_4}=", 'D')

    expect(subject.send(attribute_1)).to eql('A')
    expect(subject.send(attribute_2)).to eql('B')
    expect(subject.send(attribute_3)).to eql('C')
    expect(subject.send(attribute_4)).to eql('D')
  end
end

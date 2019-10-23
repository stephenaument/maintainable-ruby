require 'minitest/autorun'
require_relative './resistor'

describe Resistor do
  let(:subject) { Resistor.new }

  describe '#tolerance' do
    it 'returns the correct value' do
      expect(subject.tolerance).must_equal '±5%'
    end
  end
end

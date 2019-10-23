require 'minitest/autorun'
require_relative './resistor'

describe Resistor do
  let(:subject) { Resistor.new(*%w[green blue yellow gold]) }

  describe '#tolerance' do
    describe 'when given 4 colors' do
      it 'returns the correct value' do
        expect(subject.tolerance).must_equal '±5%'
      end
    end

    describe 'when given 5 colors' do
      let(:subject) { Resistor.new(*%w[red orange violet black brown]) }

      it 'returns the correct value' do
        expect(subject.tolerance).must_equal '±1%'
      end
    end

    describe 'all the colors' do
      let(:tolerance_values) do
        {
          'brown' => '±1%',
          'red' => '±2%',
          'green' => '±0.5%',
          'blue' => '±0.25%',
          'violet' => '±0.1%',
          'grey' => '±0.05%',
          'gray' => '±0.05%',
          'gold' => '±5%',
          'silver' => '±10%',
        }
      end

      it 'just works' do
        tolerance_values.each do |color, tolerance|
          subject = Resistor.new('green', 'blue', 'yellow', color)

          expect(subject.tolerance).must_equal tolerance
        end
      end
    end
  end
end

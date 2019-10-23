require 'minitest/autorun'
require_relative './resistor'

describe Resistor do
  let(:subject) { Resistor.new(*%w[green blue yellow gold]) }

  describe '#multiplier' do
    describe 'when given 4 colors' do
      it 'returns the correct value' do
        expect(subject.multiplier).must_equal 10_000
      end
    end

    describe 'when given 5 colors' do
      let(:subject) { Resistor.new(*%w[red orange violet black brown]) }

      it 'returns the correct valeu' do
        expect(subject.multiplier).must_equal 1
      end
    end

    describe 'all the colors' do
      let(:multiplier_values) do
        {
          'black'  => 1,
          'brown'  => 10,
          'red'    => 100,
          'orange' => 1_000,
          'yellow' => 10_000,
          'green'  => 100_000,
          'blue'   => 1_000_000,
          'violet' => 10_000_000,
          'grey'   => 100_000_000,
          'gray'   => 100_000_000,
          'white'  => 1_000_000_000,
          'gold'   => 0.1,
          'silver' => 0.01,
        }
      end

      it 'just works' do
        multiplier_values.each do |color, multiplier|
          subject = Resistor.new('green', 'blue', color, 'gold')

          expect(subject.multiplier).must_equal multiplier
        end
      end
    end
  end

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
          'brown'  => '±1%',
          'red'    => '±2%',
          'green'  => '±0.5%',
          'blue'   => '±0.25%',
          'violet' => '±0.1%',
          'grey'   => '±0.05%',
          'gray'   => '±0.05%',
          'gold'   => '±5%',
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

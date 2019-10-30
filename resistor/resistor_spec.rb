require 'minitest/autorun'
require_relative './resistor'

describe Resistor do
  let(:four_colors) { %w[green blue yellow gold] }
  let(:five_colors) { %w[red orange violet black brown] }
  let(:colors) { four_colors }
  let(:subject) { Resistor.new(*colors) }

  describe '#digits' do
    describe 'when given 4 color bands' do
      it 'returns a 2 digit number' do
        expect(subject.digits).must_equal 56
      end
    end

    describe 'when given 5 color bands' do
      let(:colors) { five_colors}

      it 'returns a 3 digit number' do
        expect(subject.digits).must_equal 237
      end
    end
  end

  describe '#human_value' do
    describe 'when given 4 colors' do
      it 'returns the correct value in human-readable form' do
        expect(subject.human_value).must_equal '560kΩ'
      end
    end

    describe 'when given 5 colors' do
      let(:colors) { five_colors}

      it 'returns the correct value in human-readable form' do
        expect(subject.human_value).must_equal '237Ω'
      end
    end

    describe 'when testing a range of values' do
      # all the resistors in my personal resistor kit
      let(:reference_results) do
        {
          %w[brown black black gold brown]     => '10Ω',
          %w[yellow violet black gold brown]   => '47Ω',
          %w[brown black black black brown]    => '100Ω',
          %w[red red black black brown]        => '220Ω',
          %w[orange orange black black brown]  => '330Ω',
          %w[yellow violet black black brown]  => '470Ω',
          %w[blue grey black black brown]      => '680Ω',
          %w[brown black black brown brown]    => '1kΩ',
          %w[red black black brown brown]      => '2kΩ',
          %w[red red black brown brown]        => '2.2kΩ',
          %w[orange orange black brown brown]  => '3.3kΩ',
          %w[yellow violet black brown brown]  => '4.7kΩ',
          %w[green brown black brown brown]    => '5.1kΩ',
          %w[blue grey black brown brown]      => '6.8kΩ',
          %w[brown black black red brown]      => '10kΩ',
          %w[red red black red brown]          => '22kΩ',
          %w[blue grey black red brown]        => '68kΩ',
          %w[brown black black orange brown]   => '100kΩ',
          %w[yellow violet black orange brown] => '470kΩ',
          %w[blue grey black orange brown]     => '680kΩ',
          %w[brown black black yellow brown]   => '1MΩ',
        }
      end

      it 'returns the correct value in human-readable form' do
        reference_results.each do |colors, expected|
          subject = Resistor.new(*colors)
          expect(subject.human_value).must_equal expected
        end
      end
    end
  end

  describe '#multiplier' do
    describe 'when given 4 colors' do
      it 'returns the correct value' do
        expect(subject.multiplier).must_equal 10_000
      end
    end

    describe 'when given 5 colors' do
      let(:colors) { five_colors }

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
      let(:colors) { five_colors }

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

  describe '#value' do
    describe 'when given 4 colors' do
      it 'returns the correct vaule in milliohms' do
        expect(subject.value).must_equal 560_000_000
      end
    end

    describe 'when given 5 colors' do
      describe 'when given 5 colors' do
        let(:colors) { five_colors }

        it 'returns the correct vaule in milliohms' do
          expect(subject.value).must_equal 237_000
        end
      end
    end
  end
end

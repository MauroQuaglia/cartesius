require_relative('../../spec_helper')
require('cartesius/hyperbola')
require('cartesius/point')

describe Cartesius::Hyperbola do
  let(:point) {Cartesius::Point}

  describe '.by_definition' do
    subject {described_class.by_definition(focus1: focus1, focus2: focus2, distance: distance)}

    context 'bad parameters' do

      context 'when focus are the same' do
        let(:focus1) {point.origin}
        let(:focus2) {point.origin}
        let(:distance) {1}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Focus points must be different!')
        end
      end

      context 'when focal axis are inclined' do
        let(:focus1) {point.origin}
        let(:focus2) {point.new(x: 1, y: 1)}
        let(:distance) {2}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Focal axis must not be inclined!')
        end
      end

      context 'when difference between distances is not less than focal distance' do
        let(:focus1) {point.new(x: -1, y: 0)}
        let(:focus2) {point.new(x: 1, y: 0)}
        let(:distance) {2}

        it 'should be fail' do
          expect {subject}.to raise_error(ArgumentError, 'Difference between distances must be less than focal distance!')
        end
      end

    end

    context 'good parameters' do

      context 'when focus on x axis' do
        let(:focus1) {point.new(x: 5, y: 0)}
        let(:focus2) {point.new(x: -5, y: 0)}
        let(:distance) {8}

        it 'should be valid: x^2/16 - y^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 5, y: 0))
          expect(subject.focus2).to eq(point.new(x: -5, y: 0))
          expect(subject.distance).to eq(8)
        end
      end

      context 'when focus on y axis' do
        let(:focus1) {point.new(x: 0, y: 5)}
        let(:focus2) {point.new(x: 0, y: -5)}
        let(:distance) {8}

        it 'should be valid: x^2/16 - y^2/9 = -1' do
          expect(subject.focus1).to eq(point.new(x: 0, y: 5))
          expect(subject.focus2).to eq(point.new(x: 0, y: -5))
          expect(subject.distance).to eq(8)
        end
      end

      context 'when focus parallel to x axis' do
        let(:focus1) {point.new(x: 6, y: 1)}
        let(:focus2) {point.new(x: -4, y: 1)}
        let(:distance) {8}

        it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = 1' do
          expect(subject.focus1).to eq(point.new(x: 6, y: 1))
          expect(subject.focus2).to eq(point.new(x: -4, y: 1))
          expect(subject.distance).to eq(8)
        end
      end

      context 'when focus parallel to y axis' do
        let(:focus1) {point.new(x: 1, y: 6)}
        let(:focus2) {point.new(x: 1, y: -4)}
        let(:distance) {8}

        it 'should be valid: (x - 1)^2/16 - (y - 1)^2/9 = -1' do
          expect(subject.focus1).to eq(point.new(x: 1, y: 6))
          expect(subject.focus2).to eq(point.new(x: 1, y: -4))
          expect(subject.distance).to eq(8)
        end
      end

    end

  end

end
require_relative('../spec_helper')
require('cartesius/validator')

describe Cartesius::Validator do

  describe '#same_points_validator' do
    subject {described_class.same_points(points)}

    context 'when a single point' do
      let(:points) {[@point.origin]}

      it 'should not raise exception' do
        expect {subject}.not_to raise_error
      end
    end

    context 'when same points' do
      let(:points) {[@point.origin, @point.origin]}

      it 'should raise exception' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'when different points' do
      let(:points) {[@point.origin, @point.new(x: 0, y: 1)]}

      it 'should raise exception' do
        expect {subject}.not_to raise_error
      end
    end
  end

  describe '#aligned_points_validator' do
    subject {described_class.aligned_points(points)}

    context 'when a single point' do
      let(:points) {[@point.origin]}

      it 'should not raise exception' do
        expect {subject}.not_to raise_error
      end
    end

    context 'when two points' do
      let(:points) {[@point.origin, @point.new(x: 0, y: 1)]}

      it 'should not raise exception' do
        expect {subject}.not_to raise_error
      end
    end

    context 'when three points aligned' do
      let(:points) {[@point.new(x: -1, y: 0), @point.origin, @point.new(x: 1, y: 0)]}

      it 'should raise exception' do
        expect {subject}.to raise_error(ArgumentError)
      end
    end

    context 'when three points not aligned' do
      let(:points) {[@point.new(x: -1, y: 0), @point.origin, @point.new(x: 1, y: 1)]}

      it 'should not raise exception' do
        expect {subject}.not_to raise_error
      end
    end
  end


end
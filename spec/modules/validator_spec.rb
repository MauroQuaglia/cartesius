require_relative('../../spec/spec_helper')

class IncludingClass
  include Validator
end

describe Validator do

  describe '#same_points_validator' do
    subject {IncludingClass.new.send(:same_points_validator, points)}

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

end
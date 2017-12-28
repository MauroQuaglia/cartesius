require_relative('../../spec_helper')

describe Cartesius::Angle do

  describe '.new' do
    subject {described_class.new}

    it 'should be private' do
      expect {subject}.to raise_error(NoMethodError)
    end
  end

  describe '.by_degrees' do
    subject {described_class.by_degrees(degrees)}

    context 'null angle' do
      let(:degrees) {0}
      it 'should be valid' do
        expect(subject.degrees).to eq(0)
        expect(subject.radiants).to eq(0)
      end
    end

    context '45 degree angle' do
      let(:degrees) {45}
      it 'should be valid' do
        expect(subject.degrees).to eq(45)
        expect(subject.radiants).to eq(Rational(Math::PI, 4))
      end
    end

    context 'right angle' do
      let(:degrees) {90}
      it 'should be valid' do
        expect(subject.degrees).to eq(90)
        expect(subject.radiants).to eq(Rational(Math::PI, 2))
      end
    end

    context 'flat angle' do
      let(:degrees) {180}
      it 'should be valid' do
        expect(subject.degrees).to eq(180)
        expect(subject.radiants).to eq(Rational(Math::PI))
      end
    end
  end

  describe '.by_radiants' do
    subject {described_class.by_radiants(radiants)}

    context 'null angle' do
      let(:radiants) {0}
      it 'should be valid' do
        expect(subject.radiants).to eq(0)
        expect(subject.degrees).to eq(0)
      end
    end

    context 'π/4 radiants angle' do
      let(:radiants) {Rational(Math::PI, 4)}
      it 'should be valid' do
        expect(subject.radiants).to eq(Rational(Math::PI, 4))
        expect(subject.degrees).to eq(45)
      end
    end

    context 'right angle' do
      let(:radiants) {Rational(Math::PI, 2)}
      it 'should be valid' do
        expect(subject.degrees).to eq(90)
        expect(subject.radiants).to eq(Rational(Math::PI, 2))
      end
    end

    context 'flat angle' do
      let(:radiants) {Math::PI}
      it 'should be valid' do
        expect(subject.radiants).to eq(Math::PI)
        expect(subject.degrees).to eq(180)
      end
    end
  end


end
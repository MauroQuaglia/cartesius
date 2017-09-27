require_relative('../../spec/spec_helper')
require_relative('../../models/line')

describe Line do

  describe '.new' do

    context 'invalid parameters' do

      it 'should fail when neither x nor y' do
        expect {
          described_class.new(x: 0, y: 0, k: 1)
        }.to raise_error(ArgumentError, 'Invalid parameters!')
      end

    end

    it 'should be the x axis' do
      line = described_class.new(x: 0, y: 1, k: 0)

      expect(line.slope).to eq(0)
      expect(line.known_term).to eq(0)
    end

    it 'should be the y axis' do
      line = described_class.new(x: 1, y: 0, k: 0)

      expect(line.slope).to eq(Float::INFINITY)
      expect(line.known_term).to eq(0)
    end

    it 'should be a generic line' do
      line = described_class.new(x: -2, y: 1, k: 3)

      expect(line.slope).to eq(2)
      expect(line.known_term).to eq(-3)
    end

    it 'should be equivalent to the generic line' do
      line = described_class.new(x: -4, y: 2, k: 6)

      expect(line.slope).to eq(2)
      expect(line.known_term).to eq(-3)
    end

  end

end
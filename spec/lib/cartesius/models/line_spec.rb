require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/line')

describe Cartesius::Line do

  describe '.new' do

    describe 'empty set' do

      it 'should reject a simple equation' do
        # 1 = 0
        expect {described_class.new(x: 0, y: 0, k: 1)}.to raise_error(ArgumentError)
      end

    end

    describe 'line' do

      it 'should accept a simple equation' do
        # y = 0
        expect {described_class.new(x: 0, y: 1, k: 0)}.not_to raise_error
      end

      it 'should accept a general equation' do
        # y = -x - 1 --> x + y + 1 = 0
        expect {described_class.new(x: 1, y: 1, k: 1)}.not_to raise_error
      end

    end

    describe 'plane' do

      it 'should reject the equation' do
        # 0 = 0
        expect {described_class.new(x: 0, y: 0, k: 0)}.to raise_error(ArgumentError)
      end

    end

  end
  
  describe '.create' do

    it 'should be a generic line' do
      line = described_class.create(slope: 2, known_term: -3)

      expect(line.slope).to eq(2)
      expect(line.known_term).to eq(-3)
    end

    it 'should be a generic line with string parameters' do
      line = described_class.create(slope: '2', known_term: '-3')

      expect(line.slope).to eq(2)
      expect(line.known_term).to eq(-3)
    end

  end

  describe '.horizontal' do

    it 'should be a horizontal line' do
      line = described_class.horizontal(known_term: 1)

      expect(line.slope).to eq(0)
      expect(line.known_term).to eq(1)
    end

    it 'should be a horizontal line with string parameters' do
      line = described_class.horizontal(known_term: '1')

      expect(line.slope).to eq(0)
      expect(line.known_term).to eq(1)
    end

  end

  describe '.vertical' do

    it 'should be a vertical line' do
      line = described_class.vertical(known_term: 1)

      expect(line.slope).to eq(Float::INFINITY)
      expect(line.known_term).to eq(1)
    end

    it 'should be a vertical line with string parameters' do
      line = described_class.vertical(known_term: '1')

      expect(line.slope).to eq(Float::INFINITY)
      expect(line.known_term).to eq(1)
    end

  end

  describe 'gradient' do

    it 'should be horizontal' do
      line = described_class.horizontal(known_term: 1)

      expect(line.horizontal?).to be_truthy
      expect(line.vertical?).to be_falsey
      expect(line.ascending?).to be_falsey
      expect(line.descending?).to be_falsey
    end

    it 'should be vertical' do
      line = described_class.vertical(known_term: 1)

      expect(line.horizontal?).to be_falsey
      expect(line.vertical?).to be_truthy
      expect(line.ascending?).to be_falsey
      expect(line.descending?).to be_falsey
    end

    it 'should be ascending' do
      line = described_class.ascending_bisector

      expect(line.horizontal?).to be_falsey
      expect(line.vertical?).to be_falsey
      expect(line.ascending?).to be_truthy
      expect(line.descending?).to be_falsey
    end

    it 'should be descending' do
      line = described_class.descending_bisector

      expect(line.horizontal?).to be_falsey
      expect(line.vertical?).to be_falsey
      expect(line.ascending?).to be_falsey
      expect(line.descending?).to be_truthy
    end
  end

  describe '.x_axis' do

    it 'should be the x axis' do
      line = described_class.x_axis

      expect(line.slope).to eq(0)
      expect(line.known_term).to eq(0)
    end

  end

  describe '.y_axis' do

    it 'should be the y axis' do
      line = described_class.y_axis

      expect(line.slope).to eq(Float::INFINITY)
      expect(line.known_term).to eq(0)
    end

  end

  describe '.ascending_bisector' do

    it 'should be the ascending bisector' do
      line = described_class.ascending_bisector

      expect(line.slope).to eq(1)
      expect(line.known_term).to eq(0)
    end

  end

  describe '.descending_bisector' do

    it 'should be the descending bisector' do
      line = described_class.descending_bisector

      expect(line.slope).to eq(-1)
      expect(line.known_term).to eq(0)
    end

  end

  describe '#==' do

    it 'should be false when not line' do
      expect(
          described_class.x_axis == NilClass
      ).to be_falsey
    end

    it 'should be false when different slope' do
      line1 = described_class.create(slope: 1, known_term: 2)
      line2 = described_class.create(slope: -1, known_term: 2)

      expect(
          line1 == line2
      ).to be_falsey
    end

    it 'should be false when different known term' do
      line1 = described_class.create(slope: 1, known_term: 2)
      line2 = described_class.create(slope: 1, known_term: -2)

      expect(
          line1 == line2
      ).to be_falsey
    end

    it 'should be true' do
      line1 = described_class.create(slope: 1, known_term: 2)
      line2 = described_class.create(slope: 1, known_term: 2)

      expect(
          line1 == line2
      ).to be_truthy
    end

  end


  describe '.x_axis?' do

    it 'should be false' do
      line = described_class.y_axis

      expect(
          line.x_axis?
      ).to be_falsey
    end

    it 'should be true' do
      line = described_class.x_axis

      expect(
          line.x_axis?
      ).to be_truthy
    end

  end

  describe '.y_axis?' do

    it 'should be false' do
      line = described_class.x_axis

      expect(
          line.y_axis?
      ).to be_falsey
    end

    it 'should be true' do
      line = described_class.y_axis

      expect(
          line.y_axis?
      ).to be_truthy
    end

  end

  describe '.ascending_bisector?' do

    it 'should be false' do
      line = described_class.x_axis

      expect(
          line.ascending_bisector?
      ).to be_falsey
    end

    it 'should be true' do
      line = described_class.ascending_bisector

      expect(
          line.ascending_bisector?
      ).to be_truthy
    end

  end

  describe '.descending_bisector?' do

    it 'should be false' do
      line = described_class.x_axis

      expect(
          line.descending_bisector?
      ).to be_falsey
    end

    it 'should be true' do
      line = described_class.descending_bisector

      expect(
          line.descending_bisector?
      ).to be_truthy
    end

  end

end
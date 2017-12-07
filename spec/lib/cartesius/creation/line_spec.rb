require_relative('../../../spec_helper')

describe Cartesius::Line do

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

  describe '.by_points' do

    it 'should fail when points are the same' do
      expect {
        described_class.by_points(point1: Cartesius::Point.origin, point2: Cartesius::Point.origin)
      }.to raise_error(ArgumentError, 'Points must be different!')
    end

    it 'should be horizontal' do
      line = described_class.by_points(point1: Cartesius::Point.origin, point2: Cartesius::Point.new(x: 1, y: 0))

      expect(line.x_axis?).to be_truthy

    end

    it 'should be vertical' do
      line = described_class.by_points(point1: Cartesius::Point.origin, point2: Cartesius::Point.new(x: 0, y: 1))

      expect(line.y_axis?).to be_truthy
    end

    it 'should be vertical' do
      line = described_class.by_points(point1: Cartesius::Point.origin, point2: Cartesius::Point.new(x: 1, y: 1))

      expect(line.ascending_bisector?).to be_truthy
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

end
require_relative('../../spec_helper')

describe Cartesius::Line do

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

  describe '.to_equation' do

    it 'should be horizontal equation' do
      line = described_class.horizontal(known_term: 1)

      expect(line.to_equation).to eq('+1y -1 = 0')
    end

    it 'should be vertical equation' do
      line = described_class.vertical(known_term: 1)

      expect(line.to_equation).to eq('+1x -1 = 0')
    end

    it 'should be the general equation' do
      line = described_class.create(slope: 2, known_term: 1)

      expect(line.to_equation).to eq('+2x -1y +1 = 0')
    end

  end

  describe '#include?' do

    it 'should be in a vertical line' do
      line = described_class.vertical(known_term: 1)

      expect(line.include?(Cartesius::Point.new(x: 1, y: -1))).to be_truthy
      expect(line.include?(Cartesius::Point.origin)).to be_falsey
    end

    it 'should be in a horizontal line' do
      line = described_class.horizontal(known_term: 1)

      expect(line.include?(Cartesius::Point.new(x: -1, y: 1))).to be_truthy
      expect(line.include?(Cartesius::Point.origin)).to be_falsey
    end

    it 'should be in a general line' do
      line = described_class.create(slope: 1, known_term: 2)

      expect(line.include?(Cartesius::Point.new(x: 1, y: 3))).to be_truthy
      expect(line.include?(Cartesius::Point.origin)).to be_falsey
    end

  end

  describe 'intercepts' do

    it 'should be only vertical' do
      line = described_class.vertical(known_term: 1)

      expect(line.x_intercept).to eq(1)
      expect(line.y_intercept).to be_nil
    end

    it 'should be only horizontal' do
      line = described_class.horizontal(known_term: 1)

      expect(line.x_intercept).to be_nil
      expect(line.y_intercept).to eq(1)
    end

    it 'should be origin' do
      line = described_class.ascending_bisector

      expect(line.x_intercept).to eq(0)
      expect(line.y_intercept).to eq(0)
    end

    it 'should general' do
      line = described_class.create(slope: 1, known_term: 2)

      expect(line.x_intercept).to eq(-2)
      expect(line.y_intercept).to eq(2)
    end

  end

  describe '#perpendicular?' do

    it 'axis should be perpendicular' do
      line1 = Cartesius::Line.x_axis
      line2 = Cartesius::Line.y_axis

      expect(line1.perpendicular?(line2)).to be_truthy
      expect(line2.perpendicular?(line1)).to be_truthy
    end

    it 'should be inclined parallel' do
      line1 = Cartesius::Line.ascending_bisector
      line2 = Cartesius::Line.descending_bisector

      expect(line1.perpendicular?(line2)).to be_truthy
      expect(line2.perpendicular?(line1)).to be_truthy
    end

  end

end
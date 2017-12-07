require_relative('../../../spec_helper')

describe Cartesius::Line do

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

  

end
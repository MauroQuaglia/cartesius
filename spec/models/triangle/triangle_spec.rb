require_relative('../../spec_helper')

describe Cartesius::Triangle do

  context 'characteristics' do

    describe '.vertices' do
      it 'should be valid' do
        a, b, c = @point.origin, @point.new(x: -1, y: 1), @point.new(x: 1, y: 0)

        triangle = @triangle.new(a: a, b: b, c: c)

        expect(triangle.vertices[:a]).to eq(a)
        expect(triangle.vertices[:b]).to eq(b)
        expect(triangle.vertices[:c]).to eq(c)
      end
    end

    describe '.sides' do
      it 'should be valid' do
        a, b, c = @point.origin, @point.new(x: -1, y: 1), @point.new(x: 1, y: 0)

        triangle = @triangle.new(a: a, b: b, c: c)

        ab = @segment.new(extreme1: a, extreme2: b)
        ac = @segment.new(extreme1: a, extreme2: c)
        bc = @segment.new(extreme1: b, extreme2: c)

        expect(triangle.sides[:a]).to eq(bc)
        expect(triangle.sides[:b]).to eq(ac)
        expect(triangle.sides[:c]).to eq(ab)
      end
    end

    describe '.angles' do
      it 'should be valid' do
        a, b, c = @point.origin, @point.new(x: 0, y: 1), @point.new(x: 1, y: 0)

        triangle = @triangle.new(a: a, b: b, c: c)

        angle_a = @angle.by_degrees(90)
        angle_b = @angle.by_degrees(45)
        angle_c = @angle.by_degrees(45)

        expect(triangle.angles[:a].congruent?(angle_a)).to be_truthy
        expect(triangle.angles[:b].congruent?(angle_b)).to be_truthy
        expect(triangle.angles[:c].congruent?(angle_c)).to be_truthy
      end
    end

  end

  describe '.perimeter' do
    subject {@triangle.new(a: @point.new(x: 0, y: 4), b: @point.origin, c: @point.new(x: 3, y: 0)).perimeter}

    it {is_expected.to eq(12)}
  end

  describe '.area' do
    subject {@triangle.new(a: @point.new(x: 0, y: 4), b: @point.origin, c: @point.new(x: 3, y: 0)).area}

    it {is_expected.to eq(6)}
  end

end
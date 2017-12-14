require_relative('../../spec_helper')

describe Cartesius::Point do

  it 'should be the origin' do
    point = described_class.origin

    expect(point.x).to eq(0)
    expect(point.y).to eq(0)
    expect(point.origin?).to be_truthy
    expect(point.to_coordinates).to eq('(0; 0)')
    expect(point.to_equation).to eq('+1x^2 +1y^2 = 0')
    expect(point.congruent?(described_class.origin)).to be_truthy
    expect(point == described_class.origin).to be_truthy
  end

  it 'should be the origin' do
    point = described_class.new(x: '-1/2', y: 1)

    expect(point.x).to eq(Rational(-1,2))
    expect(point.y).to eq(1)
    expect(point.origin?).to be_falsey
    expect(point.to_coordinates).to eq('(-1/2; 1)')
    expect(point.to_equation).to eq('+1x^2 +1y^2 +1x -2y +(5/4) = 0')
    expect(point.congruent?(described_class.origin)).to be_truthy
    expect(point == described_class.origin).to be_falsey
  end
  
end
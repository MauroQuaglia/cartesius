require_relative('../spec_helper')
require('cartesius/point')

describe Cartesius::Point do
  let(:point) {Cartesius::Point}

  it 'should validate the characteristics of the origin' do
    point = described_class.origin

    expect(point.origin?).to be_truthy
    expect(point.to_coordinates).to eq('(0; 0)')
    expect(point.to_equation).to eq('+1x^2 +1y^2 = 0')
  end

  it 'should validate the characteristics of the generic origin' do
    point = described_class.new(x: 1, y: 1)

    expect(point.origin?).to be_falsey
    expect(point.to_coordinates).to eq('(1; 1)')
    expect(point.to_equation).to eq('+1x^2 +1y^2 -2x -2y +2 = 0')
  end

end
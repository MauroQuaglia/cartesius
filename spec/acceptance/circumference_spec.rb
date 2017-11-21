require_relative('../spec_helper')
require('cartesius/circumference')
require('cartesius/point')
require('cartesius/segment')

describe Cartesius::Circumference do
  let(:point) {Cartesius::Point}
  let(:segment) {Cartesius::Segment}

  it 'should validate the characteristics of a simple equation with center in origin' do
    # x^2 + y^2 = 4 --> x^2 + y^2 - 4 = 0
    circumference = described_class.new(x: 0, y: 0, k: -4)

    expect(circumference.center).to eq(point.origin)
    expect(circumference.radius).to eq(2)
    expect(circumference.eccentricity).to eq(0)
    expect(circumference.to_equation).to eq('+1x^2 +1y^2 -4 = 0')
  end

  it 'should validate the characteristics of a general equation' do
    # (x - 1)^2 + (y - 1)^2 = 4 --> x^2 + y^2 -2x -2y - 2 = 0
    circumference = described_class.new(x: -2, y: -2, k: -2)

    expect(circumference.center).to eq(point.new(x:1,y:1))
    expect(circumference.radius).to eq(2)
    expect(circumference.eccentricity).to eq(0)
    expect(circumference.to_equation).to eq('+1x^2 +1y^2 -2x -2y -2 = 0')
  end

end
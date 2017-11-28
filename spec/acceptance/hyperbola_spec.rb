require_relative('../spec_helper')

describe Cartesius::Hyperbola do
  let(:point) {Cartesius::Point}
  let(:segment) {Cartesius::Segment}
  let(:line) {Cartesius::Line}

  it 'should validate the characteristics of a simple equation with focus on x axis' do
    # x^2/16 - y^2/9 = 1 --> 9x^2 - 16y^2 - 144 = 0
    hyperbola = described_class.new(x2: 9, y2: -16, x: 0, y: 0, k: -144)

    expect(hyperbola.focus1).to eq(point.new(x: 5, y: 0))
    expect(hyperbola.focus2).to eq(point.new(x: -5, y: 0))
    expect(hyperbola.focal_axis).to eq(segment.new(extreme1: point.new(x: -5, y: 0), extreme2: point.new(x: 5, y: 0)))
    expect(hyperbola.distance).to eq(8)
    expect(hyperbola.center).to eq(point.origin)
    expect(hyperbola.vertices).to eq([point.new(x: -4, y: 0), point.new(x: 4, y: 0)])
    expect(hyperbola.transverse_axis).to eq(segment.new(extreme1: point.new(x: -4, y: 0), extreme2: point.new(x: 4, y: 0)))
    expect(hyperbola.not_transverse_axis).to eq(segment.new(extreme1: point.new(x: 0, y: -3), extreme2: point.new(x: 0, y: 3)))
    expect(hyperbola.eccentricity).to eq(Rational('5/4'))
    expect(hyperbola.equilateral?).to be_falsey
    expect(hyperbola.ascending_asymptote).to eq(line.new(x: 3, y: -4, k: 0))
    expect(hyperbola.descending_asymptote).to eq(line.new(x: 3, y: 4, k: 0))
    expect(hyperbola.to_equation).to eq('+9x^2 -16y^2 -144 = 0')
  end

  it 'should validate the characteristics of a simple equation with focus on y axis' do
    # x^2/16 - y^2/9 = -1 --> 9x^2 - 16y^2 + 144 = 0
    hyperbola = described_class.new(x2: 9, y2: -16, x: 0, y: 0, k: 144)

    expect(hyperbola.focus1).to eq(point.new(x: 0, y: 5))
    expect(hyperbola.focus2).to eq(point.new(x: 0, y: -5))
    expect(hyperbola.focal_axis).to eq(segment.new(extreme1: point.new(x: 0, y: -5), extreme2: point.new(x: 0, y: 5)))
    expect(hyperbola.distance).to eq(6)
    expect(hyperbola.center).to eq(point.origin)
    expect(hyperbola.vertices).to eq([point.new(x: 0, y: -3), point.new(x: 0, y: 3)])
    expect(hyperbola.transverse_axis).to eq(segment.new(extreme1: point.new(x: 0, y: -3), extreme2: point.new(x: 0, y: 3)))
    expect(hyperbola.not_transverse_axis).to eq(segment.new(extreme1: point.new(x: -4, y: 0), extreme2: point.new(x: 4, y: 0)))
    expect(hyperbola.eccentricity).to eq(Rational('5/3'))
    expect(hyperbola.equilateral?).to be_falsey
    expect(hyperbola.ascending_asymptote).to eq(line.new(x: 3, y: -4, k: 0))
    expect(hyperbola.descending_asymptote).to eq(line.new(x: 3, y: 4, k: 0))
    expect(hyperbola.to_equation).to eq('+9x^2 -16y^2 +144 = 0')
  end

  it 'should validate the characteristics of a general equation with focus on x axis' do
    # (x - 1)^2/16 - (y - 1)^2/9 = 1 --> 9x^2 - 16y^2 - 18x + 32y - 151 = 0
    hyperbola = described_class.new(x2: 9, y2: -16, x: -18, y: 32, k: -151)

    expect(hyperbola.focus1).to eq(point.new(x: 6, y: 1))
    expect(hyperbola.focus2).to eq(point.new(x: -4, y: 1))
    expect(hyperbola.focal_axis).to eq(segment.new(extreme1: point.new(x: -4, y: 1), extreme2: point.new(x: 6, y: 1)))
    expect(hyperbola.distance).to eq(8)
    expect(hyperbola.center).to eq(point.new(x: 1, y: 1))
    expect(hyperbola.vertices).to eq([point.new(x: -3, y: 1), point.new(x: 5, y: 1)])
    expect(hyperbola.transverse_axis).to eq(segment.new(extreme1: point.new(x: -3, y: 1), extreme2: point.new(x: 5, y: 1)))
    expect(hyperbola.not_transverse_axis).to eq(segment.new(extreme1: point.new(x: 1, y: -2), extreme2: point.new(x: 1, y: 4)))
    expect(hyperbola.eccentricity).to eq(Rational('5/4'))
    expect(hyperbola.equilateral?).to be_falsey
    expect(hyperbola.ascending_asymptote).to eq(line.new(x: 3, y: -4, k: 1))
    expect(hyperbola.descending_asymptote).to eq(line.new(x: 3, y: 4, k: -7))
    expect(hyperbola.to_equation).to eq('+9x^2 -16y^2 -18x +32y -151 = 0')
  end

  it 'should validate the characteristics of a general equation with focus on y axis' do
    # (x - 1)^2/16 - (y - 1)^2/9 = -1 --> 9x^2 - 16y^2 - 18x + 32y + 137 = 0
    hyperbola = described_class.new(x2: 9, y2: -16, x: -18, y: 32, k: 137)

    expect(hyperbola.focus1).to eq(point.new(x: 1, y: 6))
    expect(hyperbola.focus2).to eq(point.new(x: 1, y: -4))
    expect(hyperbola.focal_axis).to eq(segment.new(extreme1: point.new(x: 1, y: -4), extreme2: point.new(x: 1, y: 6)))
    expect(hyperbola.distance).to eq(6)
    expect(hyperbola.center).to eq(point.new(x: 1, y: 1))
    expect(hyperbola.vertices).to eq([point.new(x: 1, y: -2), point.new(x: 1, y: 4)])
    expect(hyperbola.transverse_axis).to eq(segment.new(extreme1: point.new(x: 1, y: -2), extreme2: point.new(x: 1, y: 4)))
    expect(hyperbola.not_transverse_axis).to eq(segment.new(extreme1: point.new(x: -3, y: 1), extreme2: point.new(x: 5, y: 1)))
    expect(hyperbola.eccentricity).to eq(Rational('5/3'))
    expect(hyperbola.equilateral?).to be_falsey
    expect(hyperbola.ascending_asymptote).to eq(line.new(x: 3, y: -4, k: 1))
    expect(hyperbola.descending_asymptote).to eq(line.new(x: 3, y: 4, k: -7))
    expect(hyperbola.to_equation).to eq('+9x^2 -16y^2 -18x +32y +137 = 0')
  end

end
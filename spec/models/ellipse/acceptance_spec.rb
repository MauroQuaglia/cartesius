require_relative('../../spec_helper')

describe Cartesius::Ellipse do
  let(:point) {Cartesius::Point}
  let(:segment) {Cartesius::Segment}

  it 'should validate the characteristics of a simple equation with focus on x axis' do
    # x^2/25 + y^2/9 = 1 --> 9x^2 + 25y^2 - 225 = 0
    ellipse = described_class.new(x2: 9, y2: 25, x: 0, y: 0, k: -225)

    expect(ellipse.focus1).to eq(point.new(x: 4, y: 0))
    expect(ellipse.focus2).to eq(point.new(x: -4, y: 0))
    expect(ellipse.focal_axis).to eq(segment.new(extreme1: point.new(x: -4, y: 0), extreme2: point.new(x: 4, y: 0)))
    expect(ellipse.distance).to eq(10)
    expect(ellipse.center).to eq(point.origin)
    expect(ellipse.vertices).to eq ([
        point.new(x: 5, y: 0), point.new(x: 0, y: -3),
        point.new(x: -5, y: 0), point.new(x: 0, y: 3)
    ])
    expect(ellipse.major_axis).to eq(segment.new(extreme1: point.new(x: -5, y: 0), extreme2: point.new(x: 5, y: 0)))
    expect(ellipse.minor_axis).to eq(segment.new(extreme1: point.new(x: 0, y: -3), extreme2: point.new(x: 0, y: 3)))
    expect(ellipse.eccentricity).to eq(Rational('4/5'))
    expect(ellipse.to_equation).to eq('+9x^2 +25y^2 -225 = 0')
  end

  it 'should validate the characteristics of a simple equation with focus on y axis' do
    # x^2 / 9 + y^2 / 25 = 1 --> 25x^2 + 9y^2 - 225 = 0
    ellipse = described_class.new(x2: 25, y2: 9, x: 0, y: 0, k: -225)

    expect(ellipse.focus1).to eq(point.new(x: 0, y: 4))
    expect(ellipse.focus2).to eq(point.new(x: 0, y: -4))
    expect(ellipse.focal_axis).to eq(segment.new(extreme1: point.new(x: 0, y: -4), extreme2: point.new(x: 0, y: 4)))
    expect(ellipse.distance).to eq(10)
    expect(ellipse.center).to eq(point.origin)
    expect(ellipse.vertices).to eq ([
        point.new(x: 3, y: 0), point.new(x: 0, y: -5),
        point.new(x: -3, y: 0), point.new(x: 0, y: 5)
    ])
    expect(ellipse.major_axis).to eq(segment.new(extreme1: point.new(x: 0, y: -5), extreme2: point.new(x: 0, y: 5)))
    expect(ellipse.minor_axis).to eq(segment.new(extreme1: point.new(x: -3, y: 0), extreme2: point.new(x: 3, y: 0)))
    expect(ellipse.eccentricity).to eq(Rational('4/5'))
    expect(ellipse.to_equation).to eq('+25x^2 +9y^2 -225 = 0')
  end

  it 'should validate the characteristics of a general equation with focus on x axis' do
    # (x - 1)^2 / 25 + (y - 1)^2 / 9 = 1 --> 9x^2 + 25y^2 - 18x - 50y - 191 = 0
    ellipse = described_class.new(x2: 9, y2: 25, x: -18, y: -50, k: -191)

    expect(ellipse.focus1).to eq(point.new(x: 5, y: 1))
    expect(ellipse.focus2).to eq(point.new(x: -3, y: 1))
    expect(ellipse.focal_axis).to eq(segment.new(extreme1: point.new(x: -3, y: 1), extreme2: point.new(x: 5, y: 1)))
    expect(ellipse.distance).to eq(10)
    expect(ellipse.center).to eq(point.new(x: 1, y: 1))
    expect(ellipse.vertices).to eq ([
        point.new(x: 6, y: 1), point.new(x: 1, y: -2),
        point.new(x: -4, y: 1), point.new(x: 1, y: 4)
    ])
    expect(ellipse.major_axis).to eq(segment.new(extreme1: point.new(x: -4, y: 1), extreme2: point.new(x: 6, y: 1)))
    expect(ellipse.minor_axis).to eq(segment.new(extreme1: point.new(x: 1, y: -2), extreme2: point.new(x: 1, y: 4)))
    expect(ellipse.eccentricity).to eq(Rational('4/5'))
    expect(ellipse.to_equation).to eq('+9x^2 +25y^2 -18x -50y -191 = 0')
  end

  it 'should validate the characteristics of a general equation with focus on y axis' do
    # (x - 1)^2 / 9 + (y - 1)^2 / 25 = 1 --> 25x^2 + 9y^2 - 50x - 18y - 191 = 0
    ellipse = described_class.new(x2: 25, y2: 9, x: -50, y: -18, k: -191)

    expect(ellipse.focus1).to eq(point.new(x: 1, y: 5))
    expect(ellipse.focus2).to eq(point.new(x: 1, y: -3))
    expect(ellipse.focal_axis).to eq(segment.new(extreme1: point.new(x: 1, y: -3), extreme2: point.new(x: 1, y: 5)))
    expect(ellipse.distance).to eq(10)
    expect(ellipse.center).to eq(point.new(x: 1, y: 1))
    expect(ellipse.vertices).to eq ([
        point.new(x: 4, y: 1), point.new(x: 1, y: -4),
        point.new(x: -2, y: 1), point.new(x: 1, y: 6)
    ])
    expect(ellipse.major_axis).to eq(segment.new(extreme1: point.new(x: 1, y: -4), extreme2: point.new(x: 1, y: 6)))
    expect(ellipse.minor_axis).to eq(segment.new(extreme1: point.new(x: -2, y: 1), extreme2: point.new(x: 4, y: 1)))
    expect(ellipse.eccentricity).to eq(Rational('4/5'))
    expect(ellipse.to_equation).to eq('+25x^2 +9y^2 -50x -18y -191 = 0')
  end

end
require_relative('../../spec/spec_helper')
require_relative('../../lib/cartesius/models/ellipse')
require_relative('../../lib/cartesius/models/point')

describe Cartesius::Ellipse do

  xit 'should validate the characteristics of a simple equation with focus on x axis' do
    # x^2 / 25 + y^2 / 9 = 1 --> 9x^2 + 25y^2 - 225 = 0
    ellipse = described_class.new(x2: 9, y2: 25, x: 0, y: 0, k: -225)

    expect(ellipse.focus1).to eq(Cartesius::Point.new(x: 4, y: 0))
    expect(ellipse.focus2).to eq(Cartesius::Point.new(x: -4, y: 0))
    expect(ellipse.focal_distance).to eq(8)
    expect(ellipse.center).to eq(Cartesius::Point.origin)
    expect(ellipse.sum_of_distances).to eq(10)
    expect(ellipse.x_semi_axis_length).to eq(5)
    expect(ellipse.y_semi_axis_length).to eq(3)
    expect(ellipse.major_semi_axis).to eq(5)
    expect(ellipse.minor_semi_axis).to eq(3)
    expect(ellipse.vertices).to eq ([
        Cartesius::Point.new(x: 5, y: 0), Cartesius::Point.new(x: 0, y: -3),
        Cartesius::Point.new(x: -5, y: 0), Cartesius::Point.new(x: 0, y: 3)
    ])
    expect(ellipse.eccentricity).to eq(Rational(4, 5))
    expect(ellipse.to_equation).to eq('+9x^2 +25y^2 -225 = 0')
  end

  xit 'should validate the characteristics of a simple equation with focus on y axis' do
    # x^2 / 9 + y^2 / 25 = 1 --> 25x^2 + 9y^2 - 225 = 0
    ellipse = described_class.new(x2: 25, y2: 9, x: 0, y: 0, k: -225)

    expect(ellipse.focus1).to eq(Cartesius::Point.new(x: 0, y: 4))
    expect(ellipse.focus2).to eq(Cartesius::Point.new(x: 0, y: -4))
    expect(ellipse.focal_distance).to eq(8)
    expect(ellipse.center).to eq(Cartesius::Point.origin)
    expect(ellipse.sum_of_distances).to eq(10)
    expect(ellipse.x_semi_axis_length).to eq(3)
    expect(ellipse.y_semi_axis_length).to eq(5)
    expect(ellipse.major_semi_axis).to eq(5)
    expect(ellipse.minor_semi_axis).to eq(3)
    expect(ellipse.vertices).to eq ([
        Cartesius::Point.new(x: 3, y: 0), Cartesius::Point.new(x: 0, y: -5),
        Cartesius::Point.new(x: -3, y: 0), Cartesius::Point.new(x: 0, y: 5)
    ])
    expect(ellipse.eccentricity).to eq(Rational(4, 5))
    expect(ellipse.to_equation).to eq('+25x^2 +9y^2 -225 = 0')
  end

  xit 'should validate the characteristics of a general equation with focus on x axis' do
    # (x - 1)^2 / 25 + (y - 1)^2 / 9 = 1 --> 9x^2 + 25y^2 - 18x - 50y - 191 = 0
    ellipse = described_class.new(x2: 9, y2: 25, x: -18, y: -50, k: -191)

    expect(ellipse.focus1).to eq(Cartesius::Point.new(x: 5, y: 1))
    expect(ellipse.focus2).to eq(Cartesius::Point.new(x: -3, y: 1))
    expect(ellipse.focal_distance).to eq(8)
    expect(ellipse.center).to eq(Cartesius::Point.new(x: 1, y: 1))
    expect(ellipse.sum_of_distances).to eq(10)
    expect(ellipse.x_semi_axis_length).to eq(5)
    expect(ellipse.y_semi_axis_length).to eq(3)
    expect(ellipse.major_semi_axis).to eq(5)
    expect(ellipse.minor_semi_axis).to eq(3)
    expect(ellipse.vertices).to eq ([
        Cartesius::Point.new(x: 6, y: 1), Cartesius::Point.new(x: 1, y: -2),
        Cartesius::Point.new(x: -4, y: 1), Cartesius::Point.new(x: 1, y: 4)
    ])
    expect(ellipse.eccentricity).to eq(Rational(4, 5))
    expect(ellipse.to_equation).to eq('+9x^2 +25y^2 -18x -50y -191 = 0')
  end

  xit 'should validate the characteristics of a general equation with focus on y axis' do
    # (x - 1)^2 / 9 + (y - 1)^2 / 25 = 1 --> 25x^2 + 9y^2 - 50x - 18y - 191 = 0
    ellipse = described_class.new(x2: 25, y2: 9, x: -50, y: -18, k: -191)

    expect(ellipse.focus1).to eq(Cartesius::Point.new(x: 1, y: 5))
    expect(ellipse.focus2).to eq(Cartesius::Point.new(x: 1, y: -3))
    expect(ellipse.focal_distance).to eq(8)
    expect(ellipse.center).to eq(Cartesius::Point.new(x: 1, y: 1))
    expect(ellipse.sum_of_distances).to eq(10)
    expect(ellipse.x_semi_axis_length).to eq(3)
    expect(ellipse.y_semi_axis_length).to eq(5)
    expect(ellipse.major_semi_axis).to eq(5)
    expect(ellipse.minor_semi_axis).to eq(3)
    expect(ellipse.vertices).to eq ([
        Cartesius::Point.new(x: 4, y: 1), Cartesius::Point.new(x: 1, y: -4),
        Cartesius::Point.new(x: -2, y: 1), Cartesius::Point.new(x: 1, y: 6)
    ])
    expect(ellipse.eccentricity).to eq(Rational(4, 5))
    expect(ellipse.to_equation).to eq('+25x^2 +9y^2 -50x -18y -191 = 0')
  end

end
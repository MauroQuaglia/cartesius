require_relative('../../spec_helper')

describe Cartesius::Parabola do
  let(:point) {Cartesius::Point}
  let(:line) {Cartesius::Line}

  it 'should validate the characteristics of a simple convex equation with vertex in origin' do
    # y = x^2
    parabola = described_class.new(x2: 1, x: 0, k: 0)

    expect(parabola.directrix).to eq(line.new(x: 0, y: 1, k: '1/4'))
    expect(parabola.focus).to eq(point.new(x: 0, y: '1/4'))
    expect(parabola.vertex).to eq(point.origin)
    expect(parabola.symmetry_axis).to eq(line.y_axis)
    expect(parabola.eccentricity).to eq(1)
    expect(parabola.to_equation).to eq('+1x^2 -1y = 0')
  end

  it 'should validate the characteristics of a simple concave equation with vertex in origin' do
    # y = -x^2
    parabola = described_class.new(x2: -1, x: 0, k: 0)

    expect(parabola.directrix).to eq(line.new(x: 0, y: 1, k: '-1/4'))
    expect(parabola.focus).to eq(point.new(x: 0, y: '-1/4'))
    expect(parabola.vertex).to eq(point.origin)
    expect(parabola.symmetry_axis).to eq(line.y_axis)
    expect(parabola.eccentricity).to eq(1)
    expect(parabola.to_equation).to eq('+1x^2 +1y = 0')
  end

  it 'should validate the characteristics of a general convex equation' do
    # x^2 -2x -y +2 = 0
    parabola = described_class.new(x2: 1, x: -2, k: 2)

    expect(parabola.directrix).to eq(line.new(x: 0, y: 1, k: '-3/4'))
    expect(parabola.focus).to eq(point.new(x: 1, y: '5/4'))
    expect(parabola.vertex).to eq(point.new(x: 1, y: 1))
    expect(parabola.symmetry_axis).to eq(line.vertical(known_term: 1))
    expect(parabola.eccentricity).to eq(1)
    expect(parabola.to_equation).to eq('+1x^2 -2x -1y +2 = 0')
  end

end
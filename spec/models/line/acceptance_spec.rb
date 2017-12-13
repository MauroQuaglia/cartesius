require_relative('../../spec_helper')

describe Cartesius::Line do
  let(:point) {Cartesius::Point}

  it 'should be the x-axis' do
    line = described_class.x_axis
    y_axis = described_class.y_axis

    expect(line.slope).to eq(0)
    expect(line.known_term).to eq(0)
    expect(line.x_axis?).to be_truthy
    expect(line.y_axis?).to be_falsey
    expect(line.ascending_bisector?).to be_falsey
    expect(line.descending_bisector?).to be_falsey
    expect(line.horizontal?).to be_truthy
    expect(line.vertical?).to be_falsey
    expect(line.inclined?).to be_falsey
    expect(line.ascending?).to be_falsey
    expect(line.descending?).to be_falsey
    expect(line.parallel?(y_axis)).to be_falsey
    expect(line.perpendicular?(y_axis)).to be_truthy
    expect(line.include?(point.origin)).to be_truthy
    expect(line.x_intercept).to be_nil
    expect(line.y_intercept).to eq(0)
    expect(line.to_equation).to eq('+1y = 0')
    expect(line.congruent?(y_axis)).to be_truthy
    expect(line == y_axis).to be_falsey
  end

  it 'should be the y-axis' do
    line = described_class.y_axis
    x_axis = described_class.x_axis

    expect(line.slope).to eq(Float::INFINITY)
    expect(line.known_term).to eq(0)
    expect(line.x_axis?).to be_falsey
    expect(line.y_axis?).to be_truthy
    expect(line.ascending_bisector?).to be_falsey
    expect(line.descending_bisector?).to be_falsey
    expect(line.horizontal?).to be_falsey
    expect(line.vertical?).to be_truthy
    expect(line.inclined?).to be_falsey
    expect(line.ascending?).to be_falsey
    expect(line.descending?).to be_falsey
    expect(line.parallel?(x_axis)).to be_falsey
    expect(line.perpendicular?(x_axis)).to be_truthy
    expect(line.include?(point.origin)).to be_truthy
    expect(line.x_intercept).to eq(0)
    expect(line.y_intercept).to be_nil
    expect(line.to_equation).to eq('+1x = 0')
    expect(line.congruent?(x_axis)).to be_truthy
    expect(line == x_axis).to be_falsey
  end

  it 'should be y - x - 1 = 0' do
    line = described_class.create(slope: 1, known_term: 1)
    x_axis = described_class.x_axis

    expect(line.slope).to eq(1)
    expect(line.known_term).to eq(1)
    expect(line.x_axis?).to be_falsey
    expect(line.y_axis?).to be_falsey
    expect(line.ascending_bisector?).to be_falsey
    expect(line.descending_bisector?).to be_falsey
    expect(line.horizontal?).to be_falsey
    expect(line.vertical?).to be_falsey
    expect(line.inclined?).to be_truthy
    expect(line.ascending?).to be_truthy
    expect(line.descending?).to be_falsey
    expect(line.parallel?(x_axis)).to be_falsey
    expect(line.perpendicular?(x_axis)).to be_falsey
    expect(line.include?(point.origin)).to be_falsey
    expect(line.x_intercept).to eq(-1)
    expect(line.y_intercept).to eq(1)
    expect(line.to_equation).to eq('+1x -1y +1 = 0')
    expect(line.congruent?(x_axis)).to be_truthy
    expect(line == x_axis).to be_falsey
  end

end
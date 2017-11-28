require_relative('../spec_helper')

describe Cartesius::Segment do
  let(:point) {Cartesius::Point}
  let(:line) {Cartesius::Line}

  it 'should validate the characteristics of a segment on the x-axis' do
    segment = described_class.new(
        extreme1: point.origin, extreme2: point.new(x: 1, y: 0)
    )

    expect(segment.extreme1).to eq(point.origin)
    expect(segment.extreme2).to eq(point.new(x: 1, y: 0))
    expect(segment.horizontal?).to be_truthy
    expect(segment.vertical?).to be_falsey
    expect(segment.inclined?).to be_falsey
    expect(segment.ascending?).to be_falsey
    expect(segment.descending?).to be_falsey
    expect(segment.to_line).to eq(line.x_axis)
    expect(segment.length).to eq(1)
    expect(segment.mid).to eq(point.new(x: '1/2', y: 0))
    expect(segment.extremes).to eq([point.origin, point.new(x: 1, y: 0)])
  end

  it 'should validate the characteristics of a generic segment' do
    segment = described_class.new(
        extreme1: point.origin, extreme2: point.new(x: 1, y: 1)
    )

    expect(segment.extreme1).to eq(point.origin)
    expect(segment.extreme2).to eq(point.new(x: 1, y: 1))
    expect(segment.horizontal?).to be_falsey
    expect(segment.vertical?).to be_falsey
    expect(segment.inclined?).to be_truthy
    expect(segment.ascending?).to be_truthy
    expect(segment.descending?).to be_falsey
    expect(segment.to_line).to eq(line.ascending_bisector)
    expect(segment.length).to eq(Math.sqrt(2))
    expect(segment.mid).to eq(point.new(x: '1/2', y: '1/2'))
    expect(segment.extremes).to eq([point.origin, point.new(x: 1, y: 1)])
  end

end
require_relative('../../spec_helper')

describe Cartesius::Segment do
  let(:point) {Cartesius::Point}
  let(:line) {Cartesius::Line}
  let(:segment) {Cartesius::Segment}
  
  describe '#to_line' do
    subject {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 0)).to_line}

    it {is_expected.to eq(line.x_axis)}
  end

  describe '#length' do
    subject {segment.new(extreme1: point.origin, extreme2: point.new(x: 1, y: 0)).length}

    it {is_expected.to eq(1)}
  end

  describe '#mid' do
    subject {segment.new(extreme1: point.new(x: -1, y: -1), extreme2: point.new(x: 1, y: 1)).mid}

    it {is_expected.to eq(point.origin)}
  end

  describe '#extremes' do
    subject {segment.new(extreme1: point.new(x: -1, y: -1), extreme2: point.new(x: 1, y: 1)).extremes}

    it {is_expected.to eq([point.new(x: -1, y: -1), point.new(x: 1, y: 1)])}
  end


end

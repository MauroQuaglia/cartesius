require_relative('../../../spec_helper')
require_relative('../../../../lib/cartesius/models/segment')

describe Cartesius::Segment do

  xit 'should be the same when points are the same' do
    expect(
        described_class.mid(point1: described_class.origin, point2: described_class.origin)
    ).to eq(described_class.origin)
  end

  xit 'should be the mid point' do
    expect(
        described_class.mid(point1: described_class.origin, point2: described_class.create(x: 2, y: 2))
    ).to eq(described_class.create(x: 1, y: 1))
  end


end
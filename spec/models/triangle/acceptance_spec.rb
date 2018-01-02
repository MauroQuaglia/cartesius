require_relative('../../spec_helper')

describe Cartesius::Triangle do

  it 'should be obtuse' do
    a, b, c = @point.origin, @point.new(x: -1, y: 1), @point.new(x: 1, y: 0)

    triangle = @triangle.new(a: a, b: b, c: c)

    expect(triangle.vertices[:a]).to eq(a)
    expect(triangle.vertices[:b]).to eq(b)
    expect(triangle.vertices[:c]).to eq(c)
  end

  it 'should be rectangle' do
  end

  it 'should be acute' do
  end

end
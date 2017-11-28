require_relative('../spec_helper')
require('cartesius/line')

describe Cartesius::Line do
  let(:line) {Cartesius::Line}

  it 'should validate the characteristics of the x-axis' do
    line = described_class.x_axis

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
    expect(line.x_intercept).to be_nil
    expect(line.y_intercept).to eq(0)
    expect(line.to_equation).to eq('+1y = 0')
  end

  it 'should validate the characteristics of the ascending_bisector' do
    line = described_class.ascending_bisector

    expect(line.slope).to eq(1)
    expect(line.known_term).to eq(0)
    expect(line.x_axis?).to be_falsey
    expect(line.y_axis?).to be_falsey
    expect(line.ascending_bisector?).to be_truthy
    expect(line.descending_bisector?).to be_falsey
    expect(line.horizontal?).to be_falsey
    expect(line.vertical?).to be_falsey
    expect(line.inclined?).to be_truthy
    expect(line.ascending?).to be_truthy
    expect(line.descending?).to be_falsey
    expect(line.x_intercept).to eq(0)
    expect(line.y_intercept).to eq(0)
    expect(line.to_equation).to eq('+1x -1y = 0')
  end

end
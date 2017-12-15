require_relative('../../spec_helper')
require 'set'

describe 'Test' do
  let(:point) {Cartesius::Point}

  it 'should be equal' do
    set1 = [point.new(x: 1, y: 0), point.new(x: 1, y: 1)].to_set
    set2 = [point.new(x: 1, y: 1), point.new(x: 1, y: 0)].to_set

    puts set1 == set2
    #puts (set1 - set2).empty?
    #puts (set1-set2).inspect

    #puts [point.origin, point1] == [point1, point.origin]
  end

end


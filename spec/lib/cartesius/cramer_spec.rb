require_relative('../../spec_helper')

describe Cramer do

  context '1 x 1' do

    it 'should fail when null matrix' do
      row1 = [0]
      known_term = [3]

      expect {
        Cramer.solution1(row1, known_term)
      }.to raise_error(ArgumentError)
    end

    it 'should have solution' do
      row1 = [3]
      known_term = [6]

      expect(
          Cramer.solution1(row1, known_term)
      ).to eq([2])
    end

  end

  context '2 x 2' do

    it 'should fail when null matrix' do
      row1 = [0, 0]
      row2 = [0, 0]
      known_term = [0, 0]

      expect {
        Cramer.solution2(row1, row2, known_term)
      }.to raise_error(ArgumentError)
    end

    it 'should fail when row zero' do
      row1 = [0, 0]
      row2 = [1, 1]
      known_term = [0, 2]

      expect {
        Cramer.solution2(row1, row2, known_term)
      }.to raise_error(ArgumentError)
    end

    it 'should fail when two identical rows' do
      row1 = [1, 2]
      row2 = [1, 2]
      known_term = [3, 3]

      expect {
        Cramer.solution2(row1, row2, known_term)
      }.to raise_error(ArgumentError)
    end

    it 'should fail when two proportional rows' do
      row1 = [1, 2]
      row2 = [2, 4]
      known_term = [3, 6]

      expect {
        Cramer.solution2(row1, row2, known_term)
      }.to raise_error(ArgumentError)
    end

    it 'should have solution' do
      row1 = [1, 2]
      row2 = [1, 0]
      known_term = [3, 1]

      expect(
          Cramer.solution2(row1, row2, known_term)
      ).to eq([1, 1])
    end

  end

  context '3 x 3' do

    it 'should fail linearly dependent' do
      row1 = [1, 1, 1]
      row2 = [2, 2, 2]
      row3 = [2, 2, 3]
      known_term = [3, 6, 7]

      expect {
        Cramer.solution3(row1, row2, row3, known_term)
      }.to raise_error(ArgumentError)
    end

    it 'should have solution' do
      row1 = [1, -2, 3]
      row2 = [0, 1, -1]
      row3 = [2, 1, 0]
      known_term = [1, -1, 3]

      expect(
          Cramer.solution3(row1, row2, row3, known_term)
      ).to eq([5, -7, -6])
    end

  end

end
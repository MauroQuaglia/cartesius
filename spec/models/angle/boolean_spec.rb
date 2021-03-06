require_relative('../../spec_helper')

describe Cartesius::Angle do
  let(:tolerance) {Rational(1, 100)}

  describe '#congruent?' do
    subject {
      @angle.by_degrees(100).congruent?(an_angle)
    }

    context 'with a non-angle' do
      let(:an_angle) {NilClass}
      it {is_expected.to be_falsey}
    end

    context 'when same width' do
      let(:an_angle) {@angle.by_degrees(100)}
      it {is_expected.to be_truthy}
    end

    context 'when approximately same width (left)' do
      let(:an_angle) {@angle.by_degrees(100 - (tolerance / 2))}
      it {is_expected.to be_truthy}
    end

    context 'when approximately same width (right)' do
      let(:an_angle) {@angle.by_degrees(100 + (tolerance / 2))}
      it {is_expected.to be_truthy}
    end

    context 'when different width (left)' do
      let(:an_angle) {@angle.by_degrees(100 - tolerance)}
      it {is_expected.to be_falsey}
    end

    context 'when different width (right)' do
      let(:an_angle) {@angle.by_degrees(100 + tolerance)}
      it {is_expected.to be_falsey}
    end

    context 'when different width' do
      let(:an_angle) {@angle.by_degrees(50)}
      it {is_expected.to be_falsey}
    end

  end

  describe '#eql?' do
    subject {
      @angle.by_degrees(100).eql?(an_angle)
    }

    context 'with a non-angle' do
      let(:an_angle) {NilClass}
      it {is_expected.to be_falsey}
    end

    context 'when same width' do
      let(:an_angle) {@angle.by_degrees(100)}
      it {is_expected.to be_truthy}
    end

    context 'when approximately same width (left)' do
      let(:an_angle) {@angle.by_degrees(100 - (tolerance / 2))}
      it {is_expected.to be_truthy}
    end

    context 'when approximately same width (right)' do
      let(:an_angle) {@angle.by_degrees(100 + (tolerance / 2))}
      it {is_expected.to be_truthy}
    end

    context 'when different width (left)' do
      let(:an_angle) {@angle.by_degrees(100 - tolerance)}
      it {is_expected.to be_falsey}
    end

    context 'when different width (right)' do
      let(:an_angle) {@angle.by_degrees(100 + tolerance)}
      it {is_expected.to be_falsey}
    end

    context 'when different width' do
      let(:an_angle) {@angle.by_degrees(50)}
      it {is_expected.to be_falsey}
    end

  end

  context 'angles' do

    context 'null angle' do
      subject {@angle.by_degrees(0)}
      it 'should be null' do
        expect(subject.null?).to be_truthy
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'approximately null angle (right)' do
      subject {@angle.by_degrees(tolerance / 2)}
      it 'should be null' do
        expect(subject.null?).to be_truthy
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'acute angle (left)' do
      subject {@angle.by_degrees(tolerance)}
      it 'should be acute' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_truthy
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'acute angle' do
      subject {@angle.by_degrees(45)}
      it 'should be acute' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_truthy
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'acute angle (right)' do
      subject {@angle.by_degrees(90 - tolerance)}
      it 'should be acute' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_truthy
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'approximately right angle (left)' do
      subject {@angle.by_degrees(90 - (tolerance / 2))}
      it 'should be right' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_truthy
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'right angle' do
      subject {@angle.by_degrees(90)}
      it 'should be right' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_truthy
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'approximately right angle (right)' do
      subject {@angle.by_degrees(90 + (tolerance / 2))}
      it 'should be right' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_truthy
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'obtuse angle (left)' do
      subject {@angle.by_degrees(90 + tolerance)}
      it 'should be obtuse' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_truthy
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'obtuse angle' do
      subject {@angle.by_degrees(135)}
      it 'should be obtuse' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_truthy
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'obtuse angle (right)' do
      subject {@angle.by_degrees(180 - tolerance)}
      it 'should be obtuse' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_truthy
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'approximately flat angle (left)' do
      subject {@angle.by_degrees(180 - (tolerance / 2))}
      it 'should be flat' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_truthy
        expect(subject.full?).to be_falsey
      end
    end

    context 'flat angle' do
      subject {@angle.by_degrees(180)}
      it 'should be flat' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_truthy
        expect(subject.full?).to be_falsey
      end
    end

    context 'approximately flat angle (right)' do
      subject {@angle.by_degrees(180 + (tolerance / 2))}
      it 'should be flat' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_truthy
        expect(subject.full?).to be_falsey
      end
    end

    context 'angle more than flat' do
      subject {@angle.by_degrees(180 + tolerance)}
      it 'should be anonymous' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context '270 angle' do
      subject {@angle.by_degrees(270)}
      it 'should be anonymous' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'angle almost full' do
      subject {@angle.by_degrees(360 - tolerance)}
      it 'should be anonymous' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_falsey
      end
    end

    context 'approximately full angle (left)' do
      subject {@angle.by_degrees(360 - (tolerance / 2))}
      it 'should be full' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_truthy
      end
    end

    context 'full angle' do
      subject {@angle.by_degrees(360)}
      it 'should be full' do
        expect(subject.null?).to be_falsey
        expect(subject.acute?).to be_falsey
        expect(subject.right?).to be_falsey
        expect(subject.obtuse?).to be_falsey
        expect(subject.flat?).to be_falsey
        expect(subject.full?).to be_truthy
      end
    end

  end

  context 'set of angles' do
    it 'should be the same set' do
      set1 = [@angle.null, @angle.right].to_set
      set2 = [@angle.right, @angle.null].to_set

      expect(set1).to eq(set2)
    end

    it 'should be one angles' do
      set = [@angle.null, @angle.null].to_set

      expect(set.count).to eq(1)
    end
  end

end

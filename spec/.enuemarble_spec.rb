# frozen_string_literal: true

require_relative './../enumerables'

describe 'Enumerable' do
  let(:arr) { [1, 2, 3, 4, 5] }
  let(:negative) { [1, -2, 3, 4] }
  let(:same_array) { [1, 1, 1, 1] }
  let(:false_array) { [false, nil] }
  let(:empty_array) { [] }

  describe '#my_each' do
    context 'when no block is given' do
      it 'should return Enumerable' do
        expect(arr.my_each).to be_a(Enumerator)
      end
    end
    context 'when block is given' do
      it 'should execute the block for each element' do
        test = []
        arr.my_each { |ele| test << ele }
        expect(test).to eq(arr)
      end

      it 'should return self with same object id' do
        array = [1, 2, 3]
        expect(array.my_each { |ele| ele }).to be(array)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'when no block is given' do
      it 'should return Enumerable' do
        expect(arr.my_each_with_index).to be_a(Enumerator)
      end
    end
    context 'when block is given' do
      it 'should execute the block for each element with index' do
        test = {}
        result = { 0 => 'a', 1 => 'b', 2 => 'c' }
        sample = %w[a b c]
        sample.my_each_with_index { |ele, i| test[i] = ele }
        expect(test).to eq(result)
      end

      it 'should return self with same object id' do
        array = [1, 2, 3]
        expect(array.my_each_with_index { |ele, _i| ele }).to be(array)
      end
    end
  end

  describe '#my_select' do
    context 'when no block is given' do
      it 'should return Enumerable' do
        expect(arr.my_each).to be_a(Enumerable)
      end
    end
    context 'when block is given' do
      it 'should return an array result passing each element to block' do
        result = [2, 4]
        test = arr
        expect(test.my_select(&:even?)).to eq(result)
      end

      it 'should return only elements returning true when passed into block' do
        expect(negative.my_select(&:positive?)).to_not include(-2)
      end
      it 'should return an an empty array if block condition is false' do
        test = arr
        expect(test.my_select { false }).to be_empty
      end
    end
  end

  describe '#my_all?' do
    context 'when block is given' do
      it 'should return true if all elements in block returns true' do
        expect(arr.my_all? { |ele| ele.is_a?(Integer) }).to be true
      end

      it 'should return false if any elements in block returns false' do
        expect([1, 2, 3, 'S'].my_all? { |ele| ele.is_a?(Integer) }).not_to be true
      end
    end
    context 'when parameter is given' do
      it 'should return true if all elements match Class parameter' do
        expect(arr.my_all?(Integer)).to be true
      end

      it 'should return true if all elements match Regex' do
        expect(%w[a b c d].my_all?(/[abcd]/)).to be true
      end

      it 'should return true if all elements match other any paramter' do
        expect(same_array.my_all?(1)).to be true
      end
    end
    context 'when no parameter is given' do
      it 'should return false if any elements do not match paramter ' do
        expect([1, 2, 3, 'S'].my_all?(Integer)).to_not be true
      end

      it 'should return true if all elements are truthy' do
        expect([1, 'a', 1.4].my_all?).to be true
      end

      it 'should return false if any elements is falsy' do
        expect([1, 'a', nil].my_all?).to_not be true
      end

      it 'should return true if empty' do
        expect(empty_array.my_all?).to be true
      end
    end
  end

  describe '#my_any?' do
    context 'when block is given' do
      it 'should return true if any elements in block returns true' do
        expect(arr.my_any? { |ele| ele.is_a?(Integer) }).to be true
      end

      it 'should return false if all elements in block returns false' do
        expect(arr.my_any? { |ele| ele.is_a?(String) }).to_not be true
      end
    end
    context 'when paramer is given' do
      it 'should return true if any elements match Class parameter' do
        expect([1, 2, 3, 's'].my_any?(String)).to be true
      end

      it 'should return true if any elements match Regex' do
        expect(%w[a b c d].my_any?(/[abcd]/)).to be true
      end

      it 'should return true if any elements match other any paramter' do
        expect([1, 1, 1, 2].my_any?(2)).to be true
      end

      it 'should return false if all elements do not match paramter ' do
        expect([1, 2, 3, 'S'].my_any?(Float)).to_not be true
      end
    end
    context 'when no parameters are given' do
      it 'should return true if any elements are truthy' do
        expect([1, nil, 1.4].my_any?).to be true
      end

      it 'should false if all elements are false' do
        expect(false_array.my_any?).to_not be true
      end

      it 'should return false if empty' do
        expect(empty_array.my_any?).to_not be true
      end
    end
  end

  describe '#my_none?' do
    context 'when block is given' do
      it 'should return true if none of the elements in block returns true' do
        expect(arr.my_none? { |ele| ele.is_a?(String) }).to be true
      end

      it 'should return false if all elements in block returns true' do
        expect(arr.my_none? { |ele| ele.is_a?(Integer) }).to_not be true
      end
    end
    context 'when paramer is given' do
      it 'should return true if no elements match Class parameter' do
        expect([1, 2, 3, 's'].my_none?(Float)).to be true
      end

      it 'should return true if no elements match Regex' do
        expect(%w[e f g h].my_none?(/[abcd]/)).to be true
      end

      it 'should return true if no elements match other none paramter' do
        expect([1, 1, 1, 2].my_none?(3)).to be true
      end

      it 'should return false if all elements match parameter ' do
        expect(arr.my_none?(Integer)).to_not be true
      end

      it 'should return true if empty' do
        expect(empty_array.my_none?).to be true
      end
    end
    context 'when no parameter is given' do
      it 'should return true if none elements are truthy' do
        expect(false_array.my_none?).to be true
      end
      it 'should return false if any elements is truthy' do
        false_array << true
        expect(false_array.my_none?).to_not be true
      end
    end
  end

  describe '#my_count' do
    context 'when block is given' do
      it 'should return the count of the elements in block returning true' do
        expect(arr.my_count { |ele| ele.is_a?(Integer) }).to eq(5)
      end

      it 'should return count zero if no elements pass the block returning true' do
        expect(arr.my_count { |ele| ele.is_a?(String) }).to eq(0)
      end
    end
    context 'when paramter is given' do
      it 'should return count of elements matching Class parameter' do
        expect([1, 2, 3, 's'].my_count(String)).to eq(1)
      end

      it 'should return count of elements matching Regex' do
        expect(%w[a b c g].my_count(/[abcd]/)).to eq(3)
      end

      it 'should return count of elements matching any other paramter' do
        expect([1, 1, 1, 2].my_count(1)).to eq(3)
      end

      it 'should return 0 all elements do not match parameter ' do
        expect([1, 2, 3, 'S'].my_count(Float)).to eq(0)
      end

      it 'should return 0 for empty enumerables' do
        expect(empty_array.my_count).to eq(0)
      end
    end
    context 'when paramter is not given' do
      it 'should return length of the array' do
        expect([1, nil, 1.4].my_count).to eq(3)
      end
      it 'should return 0 for empty enumerables' do
        expect(empty_array.my_count).to eq(0)
      end
    end
  end

  describe '#my_map' do
    it 'should return Enumerator when no proc or block is given' do
      expect([1, 2, 3].my_map).to be_a(Enumerable)
    end
    context 'When proc is given' do
      it 'should return an array mapping every element through calling the proc' do
        result = [10, 20, 30, 40, 50]
        proc = proc { |ele| ele * 10 }
        expect(arr.my_map(proc)).to eq(result)
      end
    end
    context 'When block is given' do
      it 'should return an array mapping every element returning from the block' do
        result = [10, 20, 30, 40, 50]
        expect(arr.my_map { |ele| ele * 10 }).to eq(result)
      end
    end
  end

  describe '#my_inject' do
    it 'should raise LocalJumpError if no block or parameters' do
      expect { arr.my_inject }.to raise_error LocalJumpError
    end

    context 'When block is given' do
      context 'when parameter is also given' do
        it 'should start from parameter and return reduced enumerable through the block' do
          expect(arr.my_inject(10) { |sum, ele| sum + ele }).to eq(25)
        end
      end
      context 'when parameter is not given' do
        it 'should start from first element and return reduced enumerable through the block' do
          expect(arr.my_inject { |sum, ele| sum + ele }).to eq(15)
        end
      end
    end
    context 'When block is not given but starting element and symbol is given' do
      it 'should start from paramter and return reduced enumerable through the symbol at second parameter' do
        expect(arr.my_inject(10, :+)).to eq(25)
        expect(arr.my_inject(10, :-)).to eq(-5)
        expect(arr.my_inject(10, :*)).to eq(1200)
      end
    end
    context 'When symbol is given as paramter' do
      it 'should start from first element and accumulate through the symbol operation' do
        expect(arr.my_inject(:+)).to eq(15)
      end
    end
  end
  describe 'multiply_els' do
    it 'should return multiplied result from multiply_els method' do
      def multiply_els(arr)
        arr.my_inject(:*)
      end
      expect(multiply_els(arr)).to eq(120)
    end
  end
end

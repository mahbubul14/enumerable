module Enumerable
  def my_each(&block)
    return to_enum unless block_given?

    each(&block)
  end

  def my_each_with_index
    return to_enum unless block_given?

    index = 0
    each do |i|
      yield i, index
      index += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    new_arr = []
    my_each { |list| new_arr << list if yield list }
    new_arr = []
  end

  def my_all?(para = nil)
    if block_given?
      my_each { |list| return false unless yield list }
    elsif para
      my_each { |list| return false unless match?(list, para) }
    else
      my_each { |list| return false unless list }
    end
    true
  end

  def my_any?(para = nil)
    if block_given?
      my_each { |ele| return true if yield ele }
    elsif para
      my_each { |ele| return true if match?(ele, para) }
    else
      my_each { |ele| return true if ele }
    end
    false
  end

  def my_none?(para = nil)
    if block_given?
      my_each { |ele| return false if yield ele }
    elsif para
      my_each { |ele| return false if match?(ele, para) }
    else
      my_each { |ele| return false if ele }
    end
    true
  end

  def my_count(para = nil)
    count = 0
    if block_given?
      my_each { |ele| count += 1 if yield ele }
    elsif para
      my_each { |ele| count += 1 if match?(ele, para) }
    else
      return length
    end
    count
  end

  def my_map(proc = nil)
    new_arr = []
    if proc
      my_each { |list| new_arr << proc.call(list) }
    elsif block_given?
      my_each { |list| new_arr << yield(list) }
    else
      return to_enum unless block_given?
    end
    new_arr
  end

  def my_inject(num = nil, sym = nil)
    array = to_a
    acc = num || array[0]
    i = num ? 0 : 1
    if block_given?
      (i...array.length).each { |idx| acc = yield(acc, array[idx]) }
    elsif num && sym
      (i...array.length).each { |idx| acc = acc.send(sym, array[idx]) }
    elsif num
      acc = array[0]
      (1...array.length).each { |idx| acc = acc.send(num, array[idx]) }
    else
      raise LocalJumpError
    end
    acc
  end
end

def multiply_els(array)
  array.my_inject(1) { |index, result| result * index }
end

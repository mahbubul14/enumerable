module Enumerable
  def my_each
    return to_enum unless block_given?
    for list in self
      yield list
    end
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
      my_each { |ele| new_arr << proc.call(ele) }
    elsif block_given?
      my_each { |ele| new_arr << yield(ele) }
    else
      return to_enum unless block_given?
    end
    new_arr
  end

  def my_inject(num = nil, sym = nil)
    if sym.instance_of?(Symbol) || sym.instance_of?(String)
      result = num
      my_each do |item|
        result = result.nil? ? item : result.send(sym, item)
      end
      result
    elsif num.instance_of?(Symbol) || num.instance_of?(String)
      result = nil
      my_each do |item|
        result = result.nil? ? item : result.send(num, item)
      end
      result
    else
      result = num
      my_each do |item|
        result = result.nil? ? item : yield(result, item)
      end
    end
    result
  end
end

def multiply_els(array)
  array.my_inject(1) { |index, result| result * index }
end

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

  def my_inject(*params)
    arr = to_a
    result = params[0] if params[0].is_a? Integer

    case params[0]
    when Symbol, String
      symbol = params[0]

    when Integer
      symbol = params[1] if params[1].is_a?(Symbol) || params[1].is_a?(String)
    end

    if symbol
      arr.my_each { |item| result = result ? result.send(symbol, item) : item }
    else
      arr.my_each { |item| result = result ? yield(result, item) : item }
    end

    result
  end
    end
    result
  end
end

def multiply_els(array)
  array.my_inject(1) { |index, result| result * index }
end

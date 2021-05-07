# rubocop:disable Style/For
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

module Enumerable
  def my_each
    return to_enum unless block_given?

    for ele in self
      yield ele
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    my_each do |ele|
      yield ele, i
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    array = []
    my_each do |i|
      array.push(i) if yield i
    end
    array
  end

  def my_all?(args = nil)
    to_a
    if block_given?
      my_each { |i| return false unless yield(i) == true }
    elsif args.nil?
      my_each { |i| return false if i == false || i.nil? }
    elsif args.instance_of?(Class)
      my_each { |i| return false if i.class.superclass != args && i.class != args }
    elsif args.instance_of?(Regexp)
      my_each { |i| return false unless args.match(i) }
    else
      my_each { |i| return false if i != args }
    end
    true
  end

  def my_any?(args = nil)
    to_a
    if block_given?
      my_each { |i| return true if yield i }
    elsif args.nil?
      my_each { |i| return true if i }
    elsif args.instance_of?(Class)
      my_each { |i| return true if i.instance_of?(args) || i.class.superclass == args }
    elsif args.instance_of?(Regexp)
      my_each { |i| return true if args.match(i) }
    else
      my_each { |i| return true if i == args }
    end
    false
  end

  def my_none?(args = nil)
    if block_given?
      my_each { |i| return false if yield i }
    elsif args.instance_of?(Regexp)
      my_each { |i| return false if args.match(i) }
    elsif args.instance_of?(Class)
      my_each { |i| return false if i.is_a?(args) }
    elsif args.nil?
      my_each { |i| return false if i }
    else
      my_each { |i| return false if i == args }
    end
    true
  end

  def my_count(*args)
    i = 0
    if block_given?
      my_each do |x|
        i += 1 if yield x
      end
    elsif args.empty?
      my_each do |_x|
        i += 1
      end
    else
      my_each do |x|
        i += 1 if x == args[0]
      end
    end
    i
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
  # rubocop:enable Style/For
  # rubocop:enable Metrics/ModuleLength
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end

def multiply_els(array)
  array.my_inject(1) { |index, result| result * index }
end

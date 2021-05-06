module Enumerable
  def my_each
    return to_enum unless block_given?
    
    for list in self
    yield list
    end
  end

  def my_each_with_index
    return to_enum unless block_given?
    i = 0
    my_each do |i|
    yield list, i
    i += 1
    end
  end

  def my_select
    return to_enum unless block_given?
    new_arr=[]
    my_each { |list| new_arr << list if yield list }
    new_arr = []
  end

  def my_all?
    return to_enum unless block_given?

    result = my_select { |x| yield x }

    length == result.length
  end

  def my_any?
    return to_enum unless block_given?
    result = my_select { |x| yield x }
    result.length.positive?
  end

  def my_none?
    return to_enum unless block_given?
    !my_any?
  end

  def my_count
    return count if count
    return length unless block_given?
    my_select { |x| yield x }.length
  end

  def my_map(my_proc = nil)
    array = []
    my_each { |x| array << my_proc.call(x) } if my_proc
    my_each { |x| array << yield(x) } if block_given?

    array
  end

  def my_inject(*args)
    case args.length
      when 1 then args.first.is_a?(Symbol) ? sym = args.first : result = args.first
      when 2 then result, sym = args.first, args.last
    end

    result ||= 0

    my_each { |x| result = block_given? ? yield(result, x) : result.send(sym, x) }

    result
  end

  def multiply_els
    my_inject(1, :*)
  end
end
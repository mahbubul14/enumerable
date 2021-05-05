
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
  end

  # def my_all?()

# [1,2,5,3].my_each{ |list| list.length}

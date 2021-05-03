
  def my_each
    return to_enum unless block_given?
    
    for item in self
    yield item
    end
  end

  def my_each_with_index
    return to-enum unless block_given?
    i = 0
    my.each do |item|
      yield item                                  
  end

[1,2,5,3].my_each{ |item| item.length}

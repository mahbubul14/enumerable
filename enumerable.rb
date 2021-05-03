
  def my_each
    return to_enum unless block_given?
    
    for item in self
    puts yield item
    end
  end
[1,2,5,3].my_each{ |item| item.length}


# %w[ant bear cat].my_each? { |word| word.length >= 3 } #=> true
# %w[ant bear cat].my_each? { |word| word.length >= 4 } #=> false
# %w[ant bear cat].my_each?(/t/)                        #=> false
# [1, 2i, 3.14].my_each?(Numeric)                       #=> true
# [nil, true, 99].my_each?                              #=> false
# [].my_each?                                           #=> true
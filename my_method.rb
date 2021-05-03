module Enumerable
  def my_each
    return to_enum unless block_given?
    for item in self
      yield item
    end
  end
end
my_array = (1..4).to_a
my_array.each{ |e| p e }
my_array.my_each{ |e| p e }



%w[ant bear cat].my_each? { |word| word.length >= 3 } #=> true
%w[ant bear cat].my_each? { |word| word.length >= 4 } #=> false
%w[ant bear cat].my_each?(/t/)                        #=> false
[1, 2i, 3.14].my_each?(Numeric)                       #=> true
[nil, true, 99].my_each?                              #=> false
[].my_each?                                           #=> true
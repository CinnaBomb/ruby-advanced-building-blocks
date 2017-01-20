module Enumerable

	def my_each
		i=0
		while i<self.size
			yield(self[i])
			i+=1
		end
		self
	end

	def my_each_with_index
		i=0
		while i<self.size
			yield(self[i], i)
			i+=1
		end
		self
	end

	def my_select
		array = []
		i=0
		while i<self.size
			array.push self[i] if yield(self[i])
			i+=1
		end
		array
	end

	def my_all?
		i=0
		while i<self.size
			return false if yield(self[i]) == false
			i+=1
		end
		true
	end

	def my_any?
		i=0
		while i<self.size
			return true if yield(self[i]) == true
			i+=1
		end
		false
	end

	def my_none?
		i=0
		while i<self.size
			return false if yield(self[i]) == true
			i+=1
		end
		true
	end

	def my_count
		count = 0
		i=0
		while i<self.size
			count+=1 if yield(self[i]) == true
			i+=1
		end
		count
	end

	def my_map
		array = []
		i=0
		while i<self.size
			array.push(yield(self[i]))
			i+=1
		end
		array
	end

	def my_inject
		count = 0
		i=0
		while i<self.size
			count+=yield(count, self[i])
			i+=1
		end
		count
	end

end


array = [1,2,3,4,5,6,7,8,9,10]

#--each tests PASSES
#puts array.my_each {|x| puts x}.inspect
#puts array.each {|x| puts x}.inspect

#--each_with_index tests PASSED
#puts array.my_each_with_index {|x, i| puts "x: #{x} and i: #{i}"}.inspect
#puts array.each_with_index {|x, i| puts "x: #{x} and i: #{i}"}.inspect

#--select tests PASSED
#puts [1,2,3,4,5,6].my_select { |num|  num.even?  }.inspect  #=> [2, 4]
#puts [1,2,3,4,5,6].select {|num| num.even?}.inspect


#FIX YEILDS
#my_all? tests  #HOW to check if yield is given!
#puts %w[ant bear cat].my_all? { |word| word.length >= 3 }.inspect #=> true
#puts %w[ant bear cat].my_all? { |word| word.length >= 4 }.inspect #=> false
#puts [nil, true, 99].my_all?.inspect                              #=> false

#my_any? tests
#puts %w[ant bear cat].any? { |word| word.length >= 3 }.inspect #=> true
#puts %w[ant bear cat].any? { |word| word.length >= 4 }.inspect #=> true
#[nil, true, 99].any?                              #=> true

#my_none? tests
#puts %w{ant bear cat}.my_none? { |word| word.length == 5 }.inspect #=> true
#puts %w{ant bear cat}.my_none? { |word| word.length >= 4 }.inspect #=> false
#[].none?                                           #=> true
#[nil].none?                                        #=> true
#[nil, false].none?                                 #=> true
#[nil, false, true].none?                           #=> false

#my_count tests
#ary = [1, 2, 4, 2, 5, 6, 7, 8]
#puts ary.my_count.inspect               #=> 4
#ary.count(2)            #=> 2
#puts ary.count{ |x| x%2==0 }.inspect #=> 3



#my_map tests
# UNDEFNIED method for range
#puts array.map {|i| i*i}.inspect
#puts (1..4).map{ |i| i*i }.inspect 
#puts (1..4).my_map { |i| i*i }.inspect      #=> [1, 4, 9, 16]
#puts (1..4).my_map { "cat"  }.inspect   #=> ["cat", "cat", "cat", "cat"]

#my_inject tests
#puts array.my_inject {|accum, x| accum + x}.inspect
# Sum some numbers
array = [5,6,7,8,9,10]
puts array.my_inject {|sum, n| sum+n}.inspect
#(5..10).reduce(:+)                             #=> 45
# Same using a block and inject
#(5..10).inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
#(5..10).reduce(1, :*)                          #=> 151200
# Same using a block
#(5..10).inject(1) { |product, n| product * n } #=> 151200
# find the longest word
=begin
longest = %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
longest                                        #=> "sheep"
=end
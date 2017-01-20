module Enumerable

	def my_each
		if block_given?
			for item in self
				yield(item)
			end
		end
		self
	end

	def my_each_with_index
		if block_given?
			i=0
			while i < self.size
				yield(self[i], i)
				i+=1
			end
		end
		self
	end

	def my_select
		array = []
		self.my_each {|item| array << item if yield(item)}
		array
	end

	def my_all?
		for item in self
			return false if yield(item) == false
		end
		true
	end

	def my_any?
		for item in self
			return true if yield(item) == true
		end
		false
	end

	def my_none?
		for item in self
			return false if yield(item) == true
		end
		true
	end

	def my_count (x = nil)
		count = 0
		if block_given?
			for item in self
				count+=1 if yield(item) == true
			end
		elsif x != nil
			for item in self
				count+=1 if x==item
			end
		else
			return self.size
		end
		count
	end

	def my_map
		array = []
		for item in self
			array << yield(item)
		end
		array
	end


	def my_inject (*args)
		if args.count ==2
			accum = args[0]
			operator = args[1]
		elsif args.count == 1
			if args[0].is_a? Symbol
				operator = args[0]
			else
				accum = args[0]
			end
		end

		if accum == nil
			accum = self.shift
		end

		if block_given?
			self.my_each {|x| accum = yield(accum, x)}
		else
			#Still working out how to use the symbol as an operator
			#self.my_each {|x| accum.send(operator).x}
		end
	accum
	end

end



#array = [1,2,3,4,5,6,7,8,9,10]

#--each tests PASSES
#puts array.my_each {|x| puts x}.inspect

#--each_with_index tests PASSED
#puts array.my_each_with_index {|x, i| puts "x: #{x} and i: #{i}"}.inspect

#--select tests PASSED
#puts array.my_select { |num|  num.even?  }.inspect  #=> [2, 4]


#--my_all? tests PASSED
#puts %w[ant bear cat].my_all? { |word| word.length >= 3 }.inspect #=> true
#puts %w[ant bear cat].my_all? { |word| word.length >= 4 }.inspect #=> false

#my_any? tests PASSED
#puts %w[ant bear cat].my_any? { |word| word.length >= 5 }.inspect #=> false
#puts %w[ant bear cat].my_any? { |word| word.length >= 4 }.inspect #=> true

#my_none? tests PASSED
#puts %w{ant bear cat}.my_none? { |word| word.length == 5 }.inspect #=> true
#puts %w{ant bear cat}.my_none? { |word| word.length >= 4 }.inspect #=> false

#my_count tests PASSED
#ary = [1, 2, 4, 2]
#puts ary.my_count.inspect            #=> 4
#puts ary.my_count(2).inspect            #=> 2
#puts ary.my_count{ |x| x%2==0 }.inspect #=> 3

#my_map tests PASSED
#array = [1,2,3,4]
#puts array.my_map { |i| i*i }.inspect      #=> [1, 4, 9, 16]
#puts array.my_map { "cat"  }.inspect   #=> ["cat", "cat", "cat", "cat"]


#my_inject tests MOSTLY PASSED
array = [5,6,7,8,9,10]

#NOT PASSED YET, need to figure out passing symbols as operators
# Sum some numbers
#puts array.my_inject(:+).inspect                             #=> 45

# Same using a block and inject
#puts array.my_inject{ |sum, n| sum + n }.inspect          #=> 45

# Same using a block
puts array.my_inject(1) { |product, n| product * n }.inspect #=> 151200

# find the longest word
=begin
longest = %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
puts longest.inspect                                        #=> "sheep"
=end
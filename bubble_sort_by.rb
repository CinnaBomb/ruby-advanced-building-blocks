def bubble_sort_by (array)

	length = array.length
	swapped = true

	until swapped == false
		swapped = false
		for i in 1..length-1
			if yield(array[i-1], array[i]) > 0

				temp = array[i-1]
				array[i-1] = array[i]
				array[i] = temp

				swapped = true
			end
		end
		length = length-1
	end

	array
end





puts bubble_sort_by(["hi","hello","hey"]) {|left,right| left.length - right.length}.inspect
# ["hi", "hey", "hello"]
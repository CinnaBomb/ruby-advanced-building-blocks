def bubble_sort (array)

	length = array.length
	swapped = true

	until swapped == false
		swapped = false
		for i in 1..length-1
			if array[i-1] > array[i]

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



#bubble_sort([4,3,78,2,0,2])
#=> [0,2,2,3,4,78]

#bubble_sort([10,9,8,7,6,5,4,3,2,1])
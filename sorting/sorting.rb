require 'pry'

class ArraySorting
	attr_accessor :array

	def initialize array
		@array = array
	end

	def bubble_sort!
		(array.size-1).downto(1).each do |j|
			(1).upto(j).each do |i|
				if array[i] < array[i-1]
					array[i], array[i-1] = array[i-1], array[i]
				end
			end	
		end
		array
	end

	def selection_sort!
		(array.size-1).downto(1).each do |j|
			max_index = j
			0.upto(j).each do |i|
				if array[i] > array[max_index]
					max_index = i
				end
			end
			array[max_index], array[j] = array[j], array[max_index]
		end
		array
	end

	def insertion_sort!
		insertion_sort(1)
	end


	def shell_sort!

		h = 1
		h = 3*h + 1 while h < array.size/9

		while h > 0 do
			insertion_sort(h)
			h /= 3
		end
		array
	end

	def insertion_sort(start)
		start.upto(array.size-1).each do |j|
			inserting_value = array[j]
			shifting = false
			(start-1).upto(j-1).each do |i|
				if inserting_value < array[i] 
					if !shifting
						shifting = true
						@carry_on_value = array[i]
						array[i] = inserting_value
					else
						array[i], @carry_on_value = @carry_on_value, array[i]
					end
				end
			end
			if shifting
				array[j] = @carry_on_value
			end
		end
		array		
	end

	def merge_sort!
		@array = merge_sort(@array)
		@array
	end


	def merge_sort(a)
		return a if a.size == 1
		left_a, right_a = split_array(a)		
		left_a = merge_sort(left_a)
		right_a = merge_sort(right_a)
		combine(left_a, right_a)
	end

	def combine(left_a, right_a)
		a = []
		while left_a.size > 0 && right_a.size > 0
			if left_a.first < right_a.first
				a << left_a.shift
			else
				a << right_a.shift
			end
		end

		if left_a.empty? && !right_a.empty?
			right_a.each {|i| a << i}
		elsif !left_a.empty? && right_a.empty?
			left_a.each {|i| a << i}
		end
		a
	end


	def split_array(a)
		mid = (a.size / 2).round
		[a.take(mid), a.drop(mid)]
	end


	def quick_sort!
		@array = partition(array)
		array
	end

	def partition(a)
		return a if a.size <= 1
		pivot = rand(0..(a.size-1))
		left = 0
		right = a.size - 1
		while left <= pivot && right >= pivot 
			if a[left] < a[pivot]
				left += 1
			else
				if a[right] >= a[pivot]
					right -= 1
				else
					a[left], a[right] = a[right], a[left]
					left += 1
					right -= 1
				end
			end	
		end
		partition(a.take(pivot))+partition(a.drop(pivot))
	end

end

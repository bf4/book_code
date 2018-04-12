#---
# Excerpted from "A Common-Sense Guide to Data Structures and Algorithms",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jwdsal for more book information.
#---
class SortableArray

  attr_reader :array

  def initialize(array)
    @array = array
  end

  def partition!(left_pointer, right_pointer)
    
    # We always choose the rightmost element as the pivot
    pivot_position = right_pointer 
    pivot = @array[pivot_position]

    # We start the right pointer immediately to the left of the pivot
    right_pointer -= 1 

    while true do

      while @array[left_pointer] < pivot do
        left_pointer += 1
      end

      while @array[right_pointer] > pivot do
        right_pointer -= 1
      end

      if left_pointer >= right_pointer
        break
      else
        swap(left_pointer, right_pointer)
      end

    end

    # As a final step, we swap the left pointer with the pivot itself
    swap(left_pointer, pivot_position)

    # We return the left_pointer for the sake of the quicksort method
    # which will appear later in this chapter
    return left_pointer
  end

  def swap(pointer_1, pointer_2)
    temp_value = @array[pointer_1]
    @array[pointer_1] = @array[pointer_2]
    @array[pointer_2] = temp_value
  end

  def quicksort!(left_index, right_index)
    #base case: the subarray has 0 or 1 elements
    if right_index - left_index <= 0
      return
    end
    
    # Partition the array and grab the position of the pivot
    pivot_position = partition!(left_index, right_index)

    # Recursively call this quicksort method on whatever is to the left 
    # of the pivot:
    quicksort!(left_index, pivot_position - 1)

    # Recursively call this quicksort method on whatever is to the right 
    # of the pivot:
    quicksort!(pivot_position + 1, right_index)
  end

  def quickselect!(kth_lowest_value, left_index, right_index)
    # If we reach a base case - that is, that the subarray has one cell,
    # we know we've found the value we're looking for
    if right_index - left_index <= 0
      return @array[left_index]
    end
    
    # Partition the array and grab the position of the pivot
    pivot_position = partition!(left_index, right_index)

    if kth_lowest_value < pivot_position
      quickselect!(kth_lowest_value, left_index, pivot_position - 1)
    elsif kth_lowest_value > pivot_position
      quickselect!(kth_lowest_value, pivot_position + 1, right_index)
    else # kth_lowest_value == pivot_position
      # if after the partition, the pivot position is in the same spot
      # as the kth lowest value, we've found the value we're looking for
      return @array[pivot_position]
    end
  end
  
end

array = [0, 5, 2, 1, 6, 3]
sortable_array = SortableArray.new(array)
sortable_array.quicksort!(0, array.length - 1)
p sortable_array.array

array = [0, 50, 20, 10, 60, 30]
sortable_array = SortableArray.new(array)
p sortable_array.quickselect!(1, 0, array.length - 1)
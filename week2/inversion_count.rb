require 'byebug'

class InversionCount
  def initialize(array)
    @count = 0
    @array = merge_sort(array)
    print @count
  end

  def merge_sort(array)
    return array if array.length <= 1

    mid_idx = array.length / 2
    left = merge_sort(array[0...mid_idx])
    right = merge_sort(array[mid_idx..-1])
    merge(left, right);
  end

  def merge(left, right)
    sorted_array = []
    while left.length > 0 && right.length > 0
      if left[0] > right[0]
        sorted_array << right.shift
        @count += left.length
      else
        sorted_array << left.shift
      end
    end

    sorted_array + left + right
  end
end


a = File.readlines('./data.txt', "\n").map do |num|
  num.chomp.to_i
end

x = InversionCount.new(a)

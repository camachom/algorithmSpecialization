require 'byebug'

class QuickSort
  def initialize(array)
    @array = array
    @length = array.length - 1
    @count = 0

    sort()
  end

  def sort(start = 0, finish = @length)
    return if start >= finish
    @count += finish - start;

    # pivot becomes three-median
    # median = find_median(start, finish)
    # @array[median], @array[start] = @array[start], @array[median]

    # pivot becomes last element
    # @array[finish], @array[start] = @array[start], @array[finish]
    border_idx = sub_routine(start, finish)

    sort(start, border_idx - 1)
    sort(border_idx + 1, finish)

    @array
  end

  def sub_routine(start, finish)
    i = start
    x = start + 1

    while x <= finish
      if @array[x] < @array[start]
        @array[x], @array[i + 1] = @array[i + 1], @array[x]
        i += 1;
      end
      x += 1
    end

    @array[i], @array[start] = @array[start], @array[i]
    i
  end

  def find_median(start, finish)
    first = @array[start]
    last = @array[finish]
    length = finish - start + 1

    if length % 2 == 0
      mid = (length / 2) - 1;
    else
      mid = length / 2
    end

    pivots = [first, last, @array[mid + start]]
    median = pivots.sort[1]

    if median == first
      return start
    elsif median == last
      return finish
    else
      return mid + start
    end
  end

end

a = File.readlines('./data.txt', "\n").map do |num|
  num.chomp.to_i
end

p QuickSort.new(a);

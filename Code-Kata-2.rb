class Judo 

  def chop(target, values)
    return -1 if values.empty?
    return -1 if target < values[0] || target > values[-1]
    return 0 if values.size == 1

    reduce_values = values.reduce(target)
    chopped_reduced = chop(target, reduce_values)

    return chopped_reduced  == -1 ?
      -1 :
      values.reduce_index(target) + chopped_reduced 
  end

private

  Array.class_eval do
    def median 
      median_index = size / 2 - 1
      ArrayElement.new(median_index, self[median_index])
    end

    def reduce(target)
      target <= median.value ?
        slice(0..median.index) :
        slice(median.index + 1..-1)
    end

    def reduce_index(target)
      target <= median.value ? 0 : median.index + 1
    end
  end

  class ArrayElement <  Struct.new(:index, :value)
  end

end

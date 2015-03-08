require "./sorter_contracts"

# Module exposing and implementing interface for parallelized sorting
module Sorter

  include SorterContracts

  public

  def Sorter.sort(unsorted, timeout = 0, ascending = true)

    #begin
      sorted = Sorter.contracted_sort(unsorted, 0, ascending)
    # rescue ContractFailure => failure
    #   puts failure.msg
    # end

    sorted
  end

  private

  def Sorter.contracted_sort(unsorted, timeout = 0, ascending = true)
    # preconditions
    SorterContracts.isEnumerable unsorted
    SorterContracts.contentsIntercomparable unsorted
    SorterContracts.hasLength unsorted
    SorterContracts.indexMutable unsorted
    SorterContracts.isBoolean ascending
    SorterContracts.integerTimeout timeout

    sorted = Array.new(Sorter.get_length(unsorted))

    #TODO thread stuff
    #TODO timer stuff

    mergesort(unsorted, 0, Sorter.get_length(unsorted) - 1, sorted, 0, ascending)

    # postconditions
    SorterContracts.isEnumerable sorted
    SorterContracts.sortedResult sorted, ascending
    SorterContracts.equalLength sorted, unsorted
    SorterContracts.isomorphicContents sorted, unsorted

    sorted
  end

  def Sorter.get_length(obj)
    # precondition
    SorterContracts.hasLength(obj)

    return obj.length if obj.respond_to? :length
    return obj.size if obj.respond_to? :size
    return obj.count if obj.respond_to? :count
  end

  def Sorter.mergesort(unsorted, left, right, sorted_output, sorted_output_left, ascending = true)
    # preconditions
    SorterContracts.isEnumerable unsorted
    SorterContracts.isEnumerable sorted_output
    SorterContracts.integers left, right, sorted_output_left
    SorterContracts.legalBounds left, right, unsorted
    SorterContracts.contentsIntercomparable unsorted
    SorterContracts.hasLength unsorted
    SorterContracts.indexReadable unsorted
    SorterContracts.indexMutable sorted_output
    SorterContracts.isBoolean ascending

    length = right - left + 1
    if length == 1
      sorted_output[sorted_output_left] = unsorted[left]
    else
      mid = (left + right) / 2
      mid_length = mid - left + 1
      unmerged = Array.new(length)

      Sorter.mergesort(unsorted, left, mid, unmerged, 0)
      Sorter.mergesort(unsorted, mid + 1, right, unmerged, mid_length)

      Sorter.merge(unmerged, 0, mid_length - 1, mid_length, length - 1, sorted_output, sorted_output_left)

    end
    #TODO recurse on partitions
    #TODO merge partitionts

    # postconditions
    SorterContracts.isEnumerable sorted_output

    sorted_output
  end

  def Sorter.merge(list, left1, right1, left2, right2, merged_output, merged_output_left, ascending = true)
    # preconditions
    SorterContracts.integers left1, right1, left2, right2, merged_output_left
    SorterContracts.isEnumerable list
    SorterContracts.isEnumerable merged_output
    SorterContracts.contentsIntercomparable list
    SorterContracts.hasLength list
    SorterContracts.indexReadable list
    SorterContracts.indexMutable merged_output
    SorterContracts.isBoolean ascending

    # ensure interval 1 is not shorter than interval 2
    if right1 - left1 < right2 - left2
      tmp = right1
      right1 = right2
      right2 = tmp
      tmp = left1
      left1 = left2
      left2 = tmp
    end

    return if right1 - left1 + 1 == 0

    mid = (left1 + right1) / 2
    pivot = Sorter.binary_search(list[mid], list, left2, right2)
    storage_idx = merged_output_left + mid - left1 + pivot - left2
    merged_output[storage_idx] = list[mid]

    #TODO use ascending somehow
    Sorter.merge(list, left1, mid - 1, left2, pivot - 1, merged_output, merged_output_left)
    Sorter.merge(list, mid + 1, right1, pivot, right2, merged_output, storage_idx + 1)

    # postconditions
    SorterContracts.isEnumerable merged_output

    merged_output
  end

  def Sorter.binary_search(target, list, left, right)
    # preconditions
    SorterContracts.isComparable target
    SorterContracts.isEnumerable list
    SorterContracts.indexReadable list
    SorterContracts.hasLength list
    SorterContracts.contentsIntercomparable list
    SorterContracts.integers left, right

    right = left > right + 1 ? left : right + 1
    while left < right do
      mid = (left + right) / 2
      if target <= list[mid]
        right = mid
      else
        left = mid + 1
      end
    end

    # postcondition
    SorterContracts.integers right

    right
  end

end

# a = [5,9,1,2,1,8]

# puts "unsorted:"
# puts a
# puts "sorted:"
# puts Sorter.sort(a)

# puts "empty:"
# puts Sorter.sort([])

# puts "singlet:"
# puts Sorter.sort([1])

# puts "nil singlet:"
# puts Sorter.sort([nil])

# puts "nil somewhere:"
# puts Sorter.sort([2, 2, nil, 9])

# puts "strings:"
# puts Sorter.sort(["text", "what", "is", "this", "words", "what", "9"])

# puts "strings and ints:"
# puts Sorter.sort(["what", 42, "numbers?"])

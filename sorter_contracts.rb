require "./contracted"

module SorterContracts

  def SorterContracts.isEnumerable(result)
    msg = "Only enumerable containers are permitted"
    raise ContractFailure, msg unless result.is_a? Enumerable
  end

  def SorterContracts.contentsComparable(unsorted)
    msg = "Only objects that are comparable may be sorted"
    raise ContractFailure, msg unless unsorted.all? { |element| element.is_a? Comparable}
  end

  def SorterContracts.contentsIntercomparable(unsorted)
    return if get_length(unsorted) < 1
    msg = "All elements must be comparable with each other."
    first = unsorted[0]
    raise ContractFailure, msg if unsorted.any? { |element| (element <=> first) == nil }
  end

  def SorterContracts.isComparable(*args)
    msg = "Parameters must be comparable"
    contentsComparable args
  end

  def SorterContracts.equalLength(arr1, arr2)
    msg = "Arrays must have equal length"
    raise ContractFailure, msg unless SorterContracts.get_length(arr1) == SorterContracts.get_length(arr2)
  end

  def SorterContracts.hasLength(unsorted)
    msg = "Container must respond to .length, .size, or .count with an Integer"

    length_response = (unsorted.respond_to? :length) && (unsorted.length.is_a? Integer)
    size_response = (unsorted.respond_to? :size) && (unsorted.size.is_a? Integer)
    count_response = (unsorted.respond_to? :count) && (unsorted.count.is_a? Integer)

    raise ContractFailure, msg unless length_response || size_response || count_response
  end

  def SorterContracts.indexReadable(unsorted)
    msg = "Container must respond to []"
    raise ContractFailure, msg unless unsorted.respond_to? :[]
  end

  def SorterContracts.indexMutable(unsorted)
    msg = "Container must respond to [] and []="
    raise ContractFailure, msg unless (unsorted.respond_to? :[]) && (unsorted.respond_to? :[]=)
  end

  def SorterContracts.isBoolean(ascending)
    msg = "Ascending sort order must be true or false"
    raise ContractFailure, msg unless !!ascending == ascending
  end

  def SorterContracts.positiveIntegerTimeout(timeout)
    msg = "Timeout must be specified by an integer number of milliseconds"
    raise ContractFailure, msg unless (timeout.is_a? Integer) && (timeout >= 0)
  end

  def SorterContracts.integers(*args)
    msg = "Parameters must be positive integers."
    raise ContractFailure, msg unless args.each.all? { |param| param.is_a?(Integer) }
  end

  def SorterContracts.legalBounds(left, right, array)
    msg = "left bound must be less than right bound, and both must be less than array length"
    raise ContractFailure, msg unless (left <= right) && (right <= SorterContracts.get_length(array))
  end

  def SorterContracts.sortedResult(result, ascending)
    msg = "Result must be sorted in #{ascending ? "ascending" : "descending"}"
    raise ContractFailure, msg unless result.each_cons(2).all? { |left, right| ascending ? left <= right : left >= right }
  end

  def SorterContracts.isomorphicContents(sorted, unsorted)
    msg = "Result must contain every value within input"
    raise ContractFailure, msg unless unsorted.all? { |element| sorted_contains(element, sorted) }
  end

  #################
  # Utility methods
  #################

  def SorterContracts.get_length(obj)
    # precondition
    hasLength(obj)

    return obj.length if obj.respond_to? :length
    return obj.size if obj.respond_to? :size
    return obj.count if obj.respond_to? :count
  end

  def SorterContracts.sorted_contains(target, list, from = 0, to = get_length(list) - 1)
    mid = (from + to) / 2

    if target < list[mid]
      return SorterContracts.sorted_contains target, list, from, mid - 1
    elsif target > list[mid]
      return SorterContracts.sorted_contains target, list, mid + 1, to
    else
      return list[mid] == target
    end
  end

end
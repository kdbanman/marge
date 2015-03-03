require "./contracted"

module SorterPreconditions

  def sortEnumerable(unsorted)
    msg = "Only enumerable containers may be sorted"
    raise ContractFailure, msg unless unsorted.is_a? Enumerable
  end

  def sortComparable(unsorted)
    msg = "Only objects comparable by <=> may be sorted"
    raise ContractFailure, msg if unsorted.any? { |element| !element.respond_to? :<=>}
  end

  def hasLength(unsorted)
    msg = "Container must respond to .length, .size, or .count with an Integer"

    length_response = (unsorted.respond_to? :length) && (unsorted.length.is_a? Integer)
    size_response = (unsorted.respond_to? :size) && (unsorted.size.is_a? Integer)
    count_response = (unsorted.respond_to? :count) && (unsorted.count.is_a? Integer)

    raise ContractFailure, msg unless length_response || size_response || count_response
  end

  def indexMutable(unsorted)
    msg = "Container must respond to [] and []="

    raise ContractFailure, msg unless (unsorted.respond_to? :[]) && (unsorted.respond_to? :[]=)
  end

  def booleanOrder(ascending)
    msg = "Ascending sort order must be true or false"
    raise ContractFailure, msg unless !!ascending == ascending
  end

  def integerTimeout(timeout)
    msg = "Timeout must be specified by an integer number of milliseconds"
    raise ContractFailure, msg unless timeout.is_a? Integer
  end

end
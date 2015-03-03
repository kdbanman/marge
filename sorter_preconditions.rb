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

  def booleanOrder(ascending)
    msg = "Ascending sort order must be true or false"
    raise ContractFailure, msg unless !!ascending == ascending
  end

  def integerTimeout(timeout)
    msg = "Timeout must be specified by an integer number of milliseconds"
    raise ContractFailure, msg unless timeout.is_a? Integer
  end

end
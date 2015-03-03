require "./contracted"

module SorterPostconditions

  def sortedResult(result, ascending)
    msg = "Result must be sorted in #{ascending ? "ascending" : "descending"}"
    raise ContractFailure, msg unless result.each_cons(2) { |left, right| ascending ? left <= right : left >= right }
  end

  def sameLength(sorted, unsorted)
    msg = "Result must be the same length as input"
    raise ContractFailure, msg unless sorted.length == unsorted.length
  end

  #Note: O(n^2) runtime.  Could be optimized by binary search over sorted list.
  def isomorphicContents(sorted, unsorted)
    msg = "Result must contain every value within input"
    raise ContractFailure, msg unless unsorted.all? { |element| sorted.include? element }
  end

end
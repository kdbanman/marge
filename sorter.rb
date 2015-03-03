require "./sorter_preconditions"
require "./sorter_postconditions"

module Sorter

  def sort(unsorted, timeout = 0, ascending = true)
    # preconditions
    sortEnumerable unsorted
    sortComparable unsorted
    hasLength unsorted
    indexMutable unsorted
    booleanOrder ascending
    integerTimeout timeout

    sorted = Array.new()

    # postconditions
    enumerableResult sorted
    sortedResult sorted, ascending
    sameLength sorted, unsorted
    isomorphicContents sorted, unsorted
  end

  def get_length(obj)
    #precondition
    hasLength(obj)

    obj.count if obj.respond_to? :count
    obj.size if obj.respond_to? :size
    obj.length if obj.respond_to? :length
  end

end
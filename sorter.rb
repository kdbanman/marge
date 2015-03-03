require "./sorter_preconditions"
require "./sorter_postconditions"

# Module exposing and implementing interface for parallelized sorting
module Sorter

  include SorterPreconditions
  include SorterPostconditions

  public

  def sort(unsorted, timeout = 0, ascending = true)
    # preconditions
    isEnumerable unsorted
    sortComparable unsorted
    hasLength unsorted
    indexMutable unsorted
    booleanOrder ascending
    integerTimeout timeout

    sorted = Array.new #TODO

    #TODO thread stuff
    #TODO mergesort

    # postconditions
    isEnumerable sorted
    sortedResult sorted, ascending
    sameLength sorted, unsorted
    isomorphicContents sorted, unsorted
  end

  private

  def get_length(obj)
    # precondition
    hasLength(obj)

    obj.size if obj.respond_to? :size
    obj.length if obj.respond_to? :length
    obj.count if obj.respond_to? :count
  end

  def mergesort(unsorted, ascending = true)
    # preconditions
    isEnumerable unsorted
    sortComparable unsorted
    hasLength unsorted
    indexMutable unsorted
    booleanOrder ascending

    sorted = Array.new #TODO

    #TODO partition
    #TODO recurse on partitions
    #TODO merge partitionts

    # postconditions
    isEnumerable sorted
    sortedResult sorted, ascending
    sameLength sorted, unsorted
    isomorphicContents sorted, unsorted

    sorted
  end

  def partition(list)
    # preconditions
    partitionMinLength list

    left = Array.new #TODO
    right = Array.new #TODO

    # postconditions
    isEnumerable left
    isEnumerable right
    partitionSumLength list, left, right

    [left, right]
  end

  def merge(left, right, ascending = true)
    # preconditions
    isEnumerable left
    isEnumerable right
    sortComparable left
    sortComparable right
    hasLength left
    hasLength right
    indexMutable left
    indexMutable right
    booleanOrder ascending

    sorted = Array.new #TODO

    #TODO walk end to end on left and right, stitching together in order

    # postconditions
    isEnumerable sorted
    sortedResult sorted, ascending
    sameLength sorted, unsorted
    isomorphicContents sorted, unsorted

    sorted
  end

end
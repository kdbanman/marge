require "./sorter"
require "./sorter_io_contracts"
require 'getoptlong'

# Module for using parallelized sorter with file contents
module SorterIO

  include SorterIOContracts

  def sort_file(filename, time, ascending)
    # preconditions
    isString filename
    fileExists filename
    fileReadable filename
    isInteger time
    isPositive time

    raw = File.read(filename)
    list = parse_list(raw)
    
    sorted = Sorter::sort(list, time, ascending)

    # postconditions
    isEnumerable sorted

    return sorted

  end

  private

  # returns an Enumerable of objects as contained in the passed string.
  # objects may be strings or numbers.
  def parse_list(string)
    # preconditions
    isString string
    stringNonempty string

    list = string.split("\n")
    out = []

    #This ugly loop is so that we can make sure the objects are comparable to one another
    #while we are walking over the string array. (no overhead)
    (0...list.length).each do |i|
      if /^[-]?\d+(\.\d+)$/.match(list[i]) #float
        out << list[i].to_f
      elsif /^[-]?\d+$/.match(list[i])  #int
        out << list[i].to_i
      else
        out << list[i]  #push it on, and let the comparable check decide if we are good
      end
      isComparable(i, out)
    end

    # postconditions
    isEnumerable out
    return out
  end

end
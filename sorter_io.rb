require "./sorter"
require "./sorter_io_contracts"

# Module for using parallelized sorter with file contents
module SorterIO

  include SorterIOContracts

  public

  def sort_file(filename)
    # preconditions
    isString filename
    fileExists filename
    fileReadable filename

    #TODO raw = File.read(filename)
    #TODO list = parse_list(raw)
    #TODO return sorted = Sorter::sort(list)

    # postconditions
    isEnumerable sorted
  end

  private

  # returns an Enumerable of objects as contained in the passed string.
  # objects may be strings or numbers.
  def parse_list(string)
    # preconditions
    isString string
    stringNonempty string

    #TODO list = split on newlines
    #TODO map to numbers if trimmed string matches regex /\d+(\.\d+)?(\n\d+(\.\d+)?)*/
    #TODO return list

    # postconditions
    isEnumerable list
  end

end
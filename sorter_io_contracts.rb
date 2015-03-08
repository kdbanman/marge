require "./contracted"

module SorterIOContracts

  def isString(string)
    msg = "Parameter must be a string"
    raise ContractFailure, msg unless string.is_a? String
  end

  def isInteger(integer)
    msg = "Time must be an Integer"
    raise ContractFailure, msg unless integer.is_a? Integer
  end

  def isPositive(number)
    msg = "Time must be a positive number"
    raise ContractFailure, msg unless number > 0
  end

  def fileExists(filename)
    msg = "Input file must be exist and not be a directory"
    raise ContractFailure, msg unless File.file? filename
  end

  def fileReadable(filename)
    msg = "Input file must be readable"
    raise ContractFailure, msg unless File.readable? filename
  end

  def stringNonempty(string)
    msg = "File contents must be nonempty"
    raise ContractFailure, msg unless string.length > 0
  end

  def isEnumerable(list)
    msg = "Only enumerable containers may be returned"
    raise ContractFailure, msg unless list.is_a? Enumerable
  end

  def isComparable(index, list)
    msg = "List must only contain comparable entries"
    raise ContractFailure, msg unless list[index] <=> list[index -1]
  end

end
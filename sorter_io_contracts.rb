require "./contracted"

module SorterIOContracts

  def isString(string)
    msg = "Parameter must be a string"
    raise ContractFailure, msg unless string.is_a? String
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

end
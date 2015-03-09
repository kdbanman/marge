class ContractFailure < StandardError

  attr_reader :msg

  def initialize(msg)
    super "\nContractFailure:  " + msg + "\n"
    @msg = msg
  end

end

class TimeoutFailure < RuntimeError
	
	def initalize()
		super "Watchdog Timer has expired"
	end
end

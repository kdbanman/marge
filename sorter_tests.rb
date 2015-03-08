gem "minitest"
require 'minitest/autorun'
require './contracted.rb'
require './sorter.rb'

class SorterTests < Minitest::Test

	include Sorter

	#--------------------Sort Tests------------------------

	#Contract Testing
	def test_enumerable_con
		assert_raises(ContractFailure) {Sorter.sort(10)}
	end

	def test_comparable_con
		assert_raises(ContractFailure) {Sorter.sort(nil)}
	end

	def test_neg_timeout
		assert_raises(ContractFailure) {Sorter.sort([10,10,10], -10)}
	end

end
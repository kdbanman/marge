gem "minitest"
require 'minitest/autorun'
require './contracted.rb'
require './sorter.rb'

class SorterTests < Minitest::Test

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

	def test_non_bool_ascending
		assert_raises(ContractFailure) {Sorter.sort([10,10,10], -10, 10)}
	end

	def test_nil_timour
		assert_raises(ContractFailure) {Sorter.sort([10,10,10], nil)}
	end

	#Sort Tests
	def test_sort_trivial
		a = [5,9,1,2,1,8]
		b = a.sort
		Sorter.sort(a)
	end

end
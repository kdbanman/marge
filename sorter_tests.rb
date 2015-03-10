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

	def test_nil_timout
		assert_raises(ContractFailure) {Sorter.sort([10,10,10], nil)}
	end

	def test_sort_empty
		assert_raises(ContractFailure) {Sorter.sort([])}
	end

	def test_sort_nil_somewhere
		a = [2, 2, nil, 9]
		assert_raises(ContractFailure) {Sorter.sort(a)}
	end

	def test_sort_mixed
		a = ["what", 42, "numbers?"]
		assert_raises(ContractFailure) {Sorter.sort(a)}
	end

        def test_timeout_error
                a = Array.new(5000).map!{ rand() }
                assert_raises(Timeout::Error) {Sorter.sort(a, 10)}
        end


        def test_sort_nil_singlet
                assert_raises(ContractFailure) {Sorter.sort([nil]) == [nil]}
        end

	#Sort Tests
	def test_sort_trivial
		a = [5,9,1,2,1,8]
		assert(Sorter.sort(a) == a.sort)
		assert(Sorter.sort(a, 0, false) == a.sort.reverse)
	end

	def test_sort_singlet
		assert(Sorter.sort([1]) == [1])
	end
	
	def test_sorts_trings
		a = ["text", "what", "is", "this", "words", "what", "9"]
		assert(Sorter.sort(a) == a.sort)
		assert(Sorter.sort(a, 0, false) == a.sort.reverse)
	end

	def test_sort_ordered
		a = [1,2,3,4,5,6]
		assert(Sorter.sort(a) == a)
		assert(Sorter.sort(a, 0, false) == a.sort.reverse)
	end

	def test_sort_descending_ordered
		a = [5,4,3,2,1]
		assert(Sorter.sort(a) == a.sort)
		assert(Sorter.sort(a, 0, false) == a.sort.reverse)
	end

	def test_same_number
		a = [1,1,1,1,1,1,1,1]
		assert(Sorter.sort(a) == a)
		assert(Sorter.sort(a, 0, false) == a.sort.reverse)
	end

	def test_negative
		a = [-10,-5, 0 -100, 10, 20]
		assert(Sorter.sort(a) == a.sort)
		assert(Sorter.sort(a, 0, false) == a.sort.reverse)
	end

	def test_negaative_floats
		a = [-10.5, -10.4, -11.3, -100.65]
		assert(Sorter.sort(a) == a.sort)
		assert(Sorter.sort(a, 0, false) == a.sort.reverse)
	end

        def test_large_random
                a = Array.new(500).map!{ (rand() * 2000 - 1000).floor }
                assert(Sorter.sort(a) == a.sort)
		assert(Sorter.sort(a, 0, false) == a.sort.reverse)
        end

        # TODO test sort other index-accessible enumerables
        # TODO test sort other comparable
        # TODO test sort custom comparator
	
end

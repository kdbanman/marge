gem "minitest"
require 'minitest/autorun'
require './contracted.rb'
require './sorter_io.rb'

class SorterIOTests < Minitest::Test

	include SorterIO

	def test_bad_file_dne
		assert_raises(ContractFailure) {sort_file("./badfile.txt")}
	end

	def test_nonstring
		assert_raises(ContractFailure) {sort_file(10)}
	end

	def test_mixed_types
		assert_raises(ContractFailure) {parse_list("10\na\n11")}
	end

	def test_empty
		assert_raises(ContractFailure) {parse_list("")}
	end

	def test_nonstring_parse
		assert_raises(ContractFailure) {parse_list(10)}
	end

	def test_integers
		assert(parse_list("10\n11").is_a? Enumerable)
	end

	def test_floats
		assert(parse_list("10.5\n11.6").is_a? Enumerable)
	end

	def test_strings
		assert(parse_list("a\nb\nc").is_a? Enumerable)
	end

	def test_neg_ints
		list = parse_list("-10\n-11")
		assert(list.is_a? Enumerable)
		list.each {|val| assert(val < 0)}
	end

	def test_neg_floats
		list = parse_list("-10.5\n-11.2")
		assert(list.is_a? Enumerable)
		list.each {|val| assert(val < 0)}
	end

	def test_proper_type_float
		list = parse_list("10.3\n11.4\n12.5")
		list.each {|val| assert(val.is_a? Float)}
	end

	def test_proper_type_int
		list = parse_list("10\n11\n12")
		list.each {|val| assert(val.is_a? Integer)}
	end

	def test_proper_type_string
		list = parse_list("a\nb\nc")
		list.each {|val| assert(val.is_a? String)}
	end

end
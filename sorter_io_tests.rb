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
		assert(parse_list("-10\n-11").is_a? Enumerable)
	end

	def test_neg_floats
		assert(parse_list("-10.5\n-11.2").is_a? Enumerable)
	end

end
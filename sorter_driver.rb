require 'getoptlong'
require './sorter_io_contracts'
require './sorter_io.rb'

#The driver for the sorter, handles cmd line interaction and starting the sort
class SorterDriver

	include SorterIOContracts
	include SorterIO

	def initialize
		#1 hour timeout default
		@milliseconds = 3600000
		@opts = GetoptLong.new(
			['--help', '-h', GetoptLong::NO_ARGUMENT],
			['-t', GetoptLong::REQUIRED_ARGUMENT],
		)
		parseArgs
	end

	def parseArgs

		if (ARGV.length == 0)
			puts "use --help"
			exit 0
		end
		begin
			@opts.each do |opt, arg|
					case opt
						when '--help'
						puts <<-eof
SorterDriver [OPTIONS] <file>

OPTIONS:
========
-t <milliseconds>
	Defualt is 1 hour
eof
						exit(0)
						when '-t'
							@milliseconds = arg.to_i
					end
			end
		rescue GetoptLong::InvalidOption
			puts "Your arguments are not correct"
			exit 0
		rescue GetoptLong::MissingArgument
			puts "You are missing a value for a flag"
			exit 0	
		rescue GetoptLong::Error
			puts "Your input is malformed"
			exit 0 
		end

		if (ARGV.length < 1)
			puts "missing a path"
			exit 0
		elsif (ARGV.length > 1)
			puts "too many paths"
			exit 0
		end

		@path = ARGV[0]
	end

	def sort
		fileExists(@path)
		isInteger(@milliseconds)
		isPositive(@milliseconds)

		puts sort_file(@path)
	end

end

if __FILE__ == $0
	sd = SorterDriver.new
	sd.sort
end
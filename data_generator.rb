file = open("./test.txt", 'w')

rnd = Random.new

(ARGV[0].to_i).times do |i|
	file << rnd.rand(0..ARGV[0].to_i * 10).to_s + "\n"
end

file.close
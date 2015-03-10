file = open("./test.txt", 'w')

rnd = Random.new

(100).times do |i|
	file << rnd.rand(0..1000).to_s + "\n"
end

file.close
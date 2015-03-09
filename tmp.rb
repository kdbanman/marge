require './sorter'

a = [0, -3, 1, 1.0001, 0, 9]

begin
    puts Sorter.sort(a)

    puts Sorter.sort(a, 100)

    puts Sorter.sort(a, 100, false)
rescue SystemStackError => e
    puts caller
end

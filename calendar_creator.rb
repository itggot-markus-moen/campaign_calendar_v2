def calendar_creator()
    if File.file?("calendar.txt") == true
        return "There already is a calendar you doofus!"
    end
    puts "Enter the number of days in a month"
    days = STDIN.gets.chomp.to_i
    puts "Enter the number of months"
    months = STDIN.gets.chomp.to_i
    months_arr = []
    i = 1
    while i <= months
        puts "Enter the name of month number #{i}"
        months_arr << STDIN.gets.chomp
        i += 1
    end
    data = months_arr.join(", ")
    data = "#{days}\n#{data}"
    File.write("calendar.txt", data)
end
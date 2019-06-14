require_relative "events.rb"

def calendar
    if File.file?("date.txt") == true
        prev_date = File.readlines("date.txt")
        day = prev_date[0].chomp.to_i
        month = prev_date[1].chomp.to_i
        year = prev_date[2].to_i
        days_passed = prev_date[3].to_i
    else
        puts "Enter day"
        day = STDIN.gets.chomp.to_i - 1
        puts "Enter month"
        month = STDIN.gets.chomp.to_i - 1
        puts "Enter year"
        year = STDIN.gets.chomp.to_i
        puts "Enter how many days have passed since the campaign started"
        days_passed = STDIN.gets.chomp.to_i
    end


    days = ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th", "21th", "22th", "23th", "24th", "25th", "26th", "27th", "28th", "29th", "30th"]
    months = ["January", "Febuary", "Mars", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    output = "#{days[day]} of #{months[month]}, #{year}"
    output += events(day, month, year)
    output += lunar_phases(day, month, year)
    output += "\n#{days_passed} days have passed since the start of the campaign."
    puts output

    continue = STDIN.gets.chomp
    while continue != "save" && continue != "Save" && continue != "MAXIMUM RESET"
        if day < days.length - 1
            day += 1
        elsif month < months.length - 1
            month += 1
            day = 0
        else
            year += 1
            month = 0
            day = 0
        end
        days_passed += 1
        output = "#{days[day]} of #{months[month]}, #{year}"
        output += events(day, month, year)
        output += lunar_phases(day, month, year)
        output += "\n#{days_passed} days have passed since the start of the campaign."
        puts output
        continue = STDIN.gets.chomp
    end
    if continue == "MAXIMUM RESET"
        File.delete("date.txt")
        return "It is done..."
    end
    data = "#{day}\n#{month}\n#{year}\n#{days_passed}"
    File.write("date.txt", data)
end

puts calendar()
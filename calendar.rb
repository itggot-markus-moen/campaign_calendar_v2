require_relative "events.rb"
require_relative "calendar_creator.rb"
require 'byebug'

def calendar
    if File.file?("date.txt")
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

    if File.file?("calendar.txt") != true
        calendar_creator()
    end

    calendar_arr = File.readlines("calendar.txt")
    daynum = calendar_arr[0].to_i
    days = []
    i = 1
    while i <= daynum
        if "#{i}"[-1] != "1" && "#{i}"[-1] != "2" && "#{i}"[-1] != "3"
            days << "#{i}th"
        elsif "#{i}"[-2] == "1"
            days << "#{i}th"
        elsif "#{i}"[-1] == "1"
            days << "#{i}st"
        elsif "#{i}"[-1] == "2"
            days << "#{i}nd"
        elsif "#{i}"[-1] == "3"
            days << "#{i}rd"
        else
            return "WTF are you doing?"
        end
        i += 1
    end
    months = calendar_arr[1].split(", ")

    output = "#{days[day]} of #{months[month]}, #{year}"
    output += events(day, month, year)
    output += lunar_phases(day, month, year, daynum, months.length)
    output += "\n#{days_passed} days have passed since the start of the campaign."
    puts output

    continue = STDIN.gets.chomp
    while continue != "save" && continue != "Save" && continue != "MAXIMUM RESET" && continue != "calendar reset"
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
        output += lunar_phases(day, month, year, daynum, months.length)
        output += "\n#{days_passed} days have passed since the start of the campaign."
        puts output
        continue = STDIN.gets.chomp
    end
    if continue == "MAXIMUM RESET"
        if File.file?("date.txt")
            File.delete("date.txt")
            return "It is done..."
        else
            return "You fool! There is nothing to reset!"
        end
    elsif continue == "calendar reset"
        if File.file?("calendar.txt")
            File.delete("calendar.txt")
            return "It is done..."
        else
            return "You fool! There is no calendar to reset!"
        end
    end
    data = "#{day}\n#{month}\n#{year}\n#{days_passed}"
    File.write("date.txt", data)
end

puts calendar()
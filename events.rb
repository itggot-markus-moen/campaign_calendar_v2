def lunar_phases(day, month, year, month_lenght, month_num)
    phases = ["Full Moon", "Waning Gibbous", "Last Quarter", "Waning Crecent", "New Moon", "Waxing Crecent", "First Quarter", "Waxing Gibbous"]
    small_moon_cycle = 30
    medium_moon_cycle = 63
    large_moon_cycle = 84
    total_days = day + month*month_lenght + year*(month_lenght*month_num)
    small_moon_mod = total_days%small_moon_cycle
    medium_moon_mod = total_days%medium_moon_cycle
    large_moon_mod = total_days%large_moon_cycle

    i = (small_moon_mod/(small_moon_cycle/(phases.length).to_f)).to_i
    small_moon = phases[i]
    j = (medium_moon_mod/(medium_moon_cycle/(phases.length).to_f)).to_i
    medium_moon = phases[j]
    k = (large_moon_mod/(large_moon_cycle/(phases.length).to_f)).to_i
    large_moon = phases[k]
    return "\nSmall Moon: #{small_moon}\nMedium Moon: #{medium_moon}\nLarge Moon: #{large_moon}"
end

def events(day, month, year)
    if File.file?("events.txt") == true
        events = File.readlines("events.txt")
        event_hash = {}
        events.each do |e|
            arr = e.split(";")
            event_hash[arr[0]] = arr[1].chomp
        end

        intervals = []
        max_interval = 100
        i = 1
        while i <= max_interval
            intervals << i
            i += 1
        end

        output = "\nEvents: "
        intervals.each do |e|
            offset = year%e
            event = event_hash["#{day}, #{month}, #{e}, #{offset}"]
            if event != nil
                if output == "\nEvents: "
                    output += "#{event}"
                else
                    output += ", #{event}"
                end
            end
        end

        if output == "\nEvents: "
            output = ""
        end
    else
        output = ""
    end
    return output
end
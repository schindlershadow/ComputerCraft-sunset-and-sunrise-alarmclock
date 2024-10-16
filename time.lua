monitor = peripheral.find("monitor")
while monitor == nil do
    monitor = peripheral.find("monitor")
end
speaker = peripheral.find("speaker")
monitor.setTextScale(1.9)

function round(num, numDecimalPlaces)
        local mult = 10^(numDecimalPlaces or 0)
        return math.floor(num * mult + 0.5) / mult
end

function playmusic(day)
    if day then
        speaker.playNote("iron_xylophone",3,1)
        sleep(0.5)
        speaker.playNote("iron_xylophone",3,2)
        sleep(0.5)
        speaker.playNote("iron_xylophone",3,3)
    else
        speaker.playNote("iron_xylophone",3,3)
        sleep(0.5)
        speaker.playNote("iron_xylophone",3,2)
        sleep(0.5)
        speaker.playNote("iron_xylophone",3,1)
    end
end

function monitorTick(formattedTime, cycle)
    x,y = monitor.getSize()
    if cycle == "sunrise" or cycle == "sunset" then
        local color = monitor.getBackgroundColour()
        if color == colors.blue then
            monitor.setBackgroundColour(colors.red)
        else
            monitor.setBackgroundColour(colors.blue)
        end
    elseif cycle == "day" then
        monitor.setBackgroundColour(colors.blue)
    else
        monitor.setBackgroundColour(colors.red)
    end
    monitor.clear()
    monitor.setCursorPos(math.floor(1+(x/2)-(#formattedTime/2)),math.floor(y/2))
    monitor.write(formattedTime)
    if cycle == "sunrise" then
        monitor.setCursorPos(math.floor(1+(x/2)-(#"Sunrise!"/2)),1+math.floor(y/2))
        monitor.write("Sunrise!")
    elseif cycle == "sunset" then
        monitor.setCursorPos(math.floor(1+(x/2)-(#"Sunset!"/2)),1+math.floor(y/2))
        monitor.write("Sunset!")
    elseif cycle == "day" then
        monitor.setCursorPos(math.floor(1+(x/2)-(#"Daytime"/2)),1+math.floor(y/2))
        monitor.write("Daytime")
    elseif cycle == "night" then
        monitor.setCursorPos(math.floor(1+(x/2)-(#"Nighttime"/2)),1+math.floor(y/2))
        monitor.write("Nighttime")
    end
end

while true do
    time = os.time()
    formattedTime = textutils.formatTime(time, false)
    print(formattedTime)
    if time >= 5 and time < 5.5 then
        monitorTick(formattedTime, "sunrise")
        print("Sunrise")
        playmusic(true)
    elseif time >= 18.32 and time < 18.82 then
        monitorTick(formattedTime, "sunset")
        print("Sunset")
        playmusic(false)
    elseif time >= 18.82 or time < 5 then
        monitorTick(formattedTime, "night")
    else
        monitorTick(formattedTime, "day")
    end
    sleep(0.5)
end    

-- Load the module
s = require("mq135")

-- Calibrate (only need to do this once for any new sensor)
-- First let it "burn in" for 12 to 24 hours, then put it into clean air for 30 to 60 minutes
-- and write down the average RZero value, the PPM shown is probably wrong right now which is why you're calibrating in the first place
tmr.create():alarm(1000, tmr.ALARM_AUTO, function()
    local rzero = s.getRZero();
    local ppm = s.getPPM(); 

    print("RZero: ", rzero, " ppm: ", ppm)
end)

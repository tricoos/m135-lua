-- Load the module
s = require("mq135")
s.setRZero(24.21206) -- Put your sensor's value as measured with calibrate.lua here
s.setRLoad(1.0) -- My Flying-Fish MQ135 module has 1 ohm resistor instead of 10 ohms

-- Read value
print(s.getPPM()..' ppm CO2')

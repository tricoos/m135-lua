# MQ135 LUA Library for ESP8266 / NodeMCU
*LUA library for reading values from MQ-135 air quality sensor via ESP8266 with NodeMCU*

As I didn't find any library for accessing the MQ-135 measurements with LUA I wrote this library with is essentially a copy of the [C library from GeorgK for Arduino](https://github.com/GeorgK/MQ135/).

# Connection to NodeMCU
This library has been tested with the [MQ-135 sensor board by Flying-Fish](http://www.ebay.com/sch/?_nkw=MQ-135) which contains a resistor and a digital output.

Simply connect the board (1) to the NodeMCU (2) unit ike this:
- GND to GND
- VCC to 3V3
- AO to AO

# Calibration And Burn-In
Before you can use the sensor you are advised to "burn in" the sensor by having it powered on for 24 hours. After

# Links
- [Calculation Info by Davide Gironi](http://davidegironi.blogspot.de/2014/01/cheap-co2-meter-using-mq135-sensor-with.html)
- [MQ135 Arduino Library](https://hackaday.io/project/3475-sniffing-trinket/log/12363-mq135-arduino-library)
- [MQ-135 datasheet](https://www.mysensors.org/dl/57c3ebeb071cb0e34c90057a/design/SNS-MQ135.pdf)
- [MQ Gas Sensors List](http://playground.arduino.cc/Main/MQGasSensors)
- [Current CO² value in the atmosphere](https://www.co2.earth/)
- [CO² Comfort Levels](http://www.engineeringtoolbox.com/co2-comfort-level-d_1024.html)
- [Effects of CO² On The Body (German)](https://de.wikipedia.org/wiki/Kohlenstoffdioxid#Physiologische_Wirkungen_und_Gefahren)

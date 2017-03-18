-- ************************************************************************
-- MQ-135 module for ESP8266 with NodeMCU (needs adc library in firmware)
--
-- Based on MQ135 Arduino library written in C from GeorgK
-- see https://github.com/GeorgK/MQ135/
-- Code by tricoos @ github.com
--
-- License: GNU General Public License v3.0
-- ************************************************************************

local moduleName = ...
local M = {}
_G[moduleName] = M

-- The load resistance on the board
local RLOAD = 10.0

-- Calibration resistance at atmospheric CO2 level
local RZERO = 76.63

-- Parameters for calculating ppm of CO2 from sensor resistance
local PARA = 116.6020682
local PARB = 2.769034857

-- Parameters to model temperature and humidity dependence
local CORA = 0.00035
local CORB = 0.02718
local CORC = 1.39538
local CORD = 0.0018

-- Atmospheric CO2 level for calibration purposes, original code had 397.13
-- Get current value from https://www.co2.earth/
local ATMOCO2 = 406.42

-- Get the correction factor to correct for temperature and humidity
-- t  The ambient air temperature
-- h  The relative humidity
-- @return The calculated correction factor
function M.getCorrectionFactor(t, h)
  return CORA * t * t - CORB * t + CORC - (h-33.0)*CORD;
end

--  Get the resistance of the sensor, ie. the measurement value
-- @return The sensor resistance in kOhm
function M.getResistance()
  local val = adc.read(0);
  return ((1023./val) * 5.0 - 1.0)*RLOAD;
end

-- Get the resistance of the sensor, ie. the measurement value corrected for temp/hum
-- t  The ambient air temperature
-- h  The relative humidity
-- @return The corrected sensor resistance kOhm
function M.getCorrectedResistance(t, h)
  return M.getResistance()/M.getCorrectionFactor(t, h);
end

-- Get the ppm of CO2 sensed (assuming only CO2 in the air)
-- @return The ppm of CO2 in the air
function M.getPPM()
  --return PARA * math.pow((getResistance()/RZERO), -PARB);
  return PARA * math.pow((M.getResistance()/RZERO), (PARB * - 1));
end

-- Get the ppm of CO2 sensed (assuming only CO2 in the air), corrected for temp/hum
-- t  The ambient air temperature
-- h  The relative humidity
-- @return The ppm of CO2 in the air
function M.getCorrectedPPM(t, h)
  --return PARA * math.pow((getCorrectedResistance(t, h)/RZERO), -PARB);
  return PARA * math.pow((M.getCorrectedResistance(t, h)/RZERO), (PARB * -1));
end

-- Get the resistance RZero of the sensor for calibration purposes
-- @return The sensor resistance RZero in kOhm
function M.getRZero()
  return M.getResistance() * math.pow((ATMOCO2/PARA), (1.0/PARB));
end

-- Get the corrected resistance RZero of the sensor for calibration purposes
-- t  The ambient air temperature
-- h  The relative humidity
-- @return The corrected sensor resistance RZero in kOhm
function M.getCorrectedRZero(t, h)
  return M.getCorrectedResistance(t, h) * math.pow((ATMOCO2/PARA), (1.0/PARB));
end 

-- override default value
function M.setRZero(resistance)
    RZERO = resistance
end

-- board resistor in ohm
function M.setRLoad(resistance)
    RLOAD = resistance
end

return M

-- This Source Code Form is subject to the terms of the bCDDL, v. 1.1.
-- If a copy of the bCDDL was not distributed with this
-- file, You can obtain one at http://beamng.com/bCDDL-1.1.txt

-- somewhat expensive clamp function to make my life easier at the expense of your framerate
-- I suppose the ideal solution would be to use if-statements, but that will be over my dead body
function math.clamp(low, n, high) return math.min(math.max(n, low), high) end


local M = {}
M.type = "auxiliary"


local fixedLog = math.log(1.5)
local electricsName = nil
local currentValue = 1


local function updateGFX(dt)
  local lowbeam = electrics.values.lowbeam
  local highbeam = electrics.values.highbeam
  local reverse = electrics.values.reverse
  local steering = input.steering
  local wheelspeed = electrics.values.wheelspeed
  local targetValue = 0
  
  -- pointless
  electrics.values[highbeams] = highbeam
  
  if lowbeam > 0 or highbeam > 0 then
  
	if reverse == 0 then
		targetValue = (steering * -12) * (math.clamp(math.log(wheelspeed) / fixedLog, 0, 100))
    else
		targetValue = 0.02
	end
	
    if targetValue == 0 then
      targetValue = 0.02
    end
      
    -- gradually move towards the target value
    local step = (targetValue - currentValue) * dt * 5.2
    local newValue = math.clamp(currentValue + step, -20, 20)
	currentValue = newValue
    electrics.values[electricsName] = newValue % 360
  else
    electrics.values[electricsName] = 0
  end
end



local function init(jbeamData)
  electricsName = jbeamData.electricsName or "corner"
  highbeams = "beams"
  electrics.values[electricsName] = 1  
end

M.init = init
M.updateGFX = updateGFX

return M

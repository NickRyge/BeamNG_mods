-- This Source Code Form is subject to the terms of the bCDDL, v. 1.1.
-- If a copy of the bCDDL was not distributed with this
-- file, You can obtain one at http://beamng.com/bCDDL-1.1.txt

local M = {}
M.type = "auxiliary"


local beaconSpeed = 0
local electricsName = nil

local function updateGFX(dt)
    
  -- and electrics.values[electricsName] < 10
  if electrics.values.lightbar > 0  then
	electrics.values[electricsName] = (input.steering*-100)%360
  else 
    
  end
  
  
   --this needs to be 0 as otherwise the spotlights stay turned on :|
end

local function init(jbeamData)
  beaconSpeed = jbeamData.spinSpeed or 100
  electricsName = jbeamData.electricsName or "beaconSpin"
  electrics.values[electricsName] = 1
end

M.init = init
M.updateGFX = updateGFX

return M

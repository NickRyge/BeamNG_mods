-- Credits: DaddelZeit

local M = {}

local leftIsOn = false
local rightIsOn = false

local function updateGFX(dt)
    if electrics.values.fog == 0 then
        if (electrics.values.wheelspeed > 13.4 and electrics.values.wheelspeed < 0.1) or electrics.values.lowhighbeam == 0 then
            leftIsOn = false
            rightIsOn = false
        else
            if electrics.values.steering < -70 then
                rightIsOn = true
            else
                rightIsOn = false
            end
            if electrics.values.steering > 70 then
                leftIsOn = true
            else
                leftIsOn = false
            end
        end

        if leftIsOn == true then
            electrics.values.cornering_L = 1
            electrics.values.cornering_R = 0
        end
        if rightIsOn == true then
            electrics.values.cornering_L = 0
            electrics.values.cornering_R = 1
        end
        if leftIsOn == false and rightIsOn == false then
            electrics.values.cornering_L = 0
            electrics.values.cornering_R = 0
        end
    else
        electrics.values.cornering_L = 1
        electrics.values.cornering_R = 1
    end
end

local function init()
    electrics.values.cornering_R = 0
    electrics.values.cornering_L = 0

    leftIsOn = false
    rightIsOn = false
end

M.reset = init
M.init = init
M.updateGFX = updateGFX

return M
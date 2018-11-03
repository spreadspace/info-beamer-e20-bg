local max = math.max
local min = math.min
local cos = math.cos
local sin = math.sin
local exp = math.exp
local PUSH = gl.pushMatrix
local POP = gl.popMatrix
local PI = math.pi
local RADTODEG = 180.0 / 3.14159265359
local DEGTORAD = 3.14159265359 / 180.0
local ROT1 = RADTODEG * PI


local fancy = {}

----------------------------------------------
-- utils

local function chaos(t)
  return (exp(sin(t*0.22))*exp(cos(t*0.39))*sin(t*0.3));
end

local function rotaterad(a, ...)
    gl.rotate(RADTODEG * a, ...)
end

local function rotate1(a, ...) -- 0.5 = half rotation, 1 = full rotation
    gl.rotate(ROT1 * a, ...)
end


----------------------------------------------
-- modes: "minimal", fancy".

function fancy.render(mode, aspect)
    aspect = aspect or (WIDTH / HEIGHT)
    local now = sys.now()
    local res = fancy.res

    if mode == "minimal" then
        res.fancy_minimalbg:draw(0, 0, WIDTH, HEIGHT)
    elseif mode == "fancy" then
        res.fancy_bgcolor:draw(0, 0, WIDTH, HEIGHT)

        local fov = math.atan2(HEIGHT, WIDTH*2) * 360 / math.pi
        gl.perspective(fov, WIDTH/2, HEIGHT/2, -WIDTH,
                        WIDTH/2, HEIGHT/2, 0)

        gl.translate(WIDTH/2, HEIGHT/2)
        gl.scale(WIDTH * (1/aspect), HEIGHT)
        if fancy.fixaspect then
            fancy.fixaspect(aspect)
        end
        -- TODO: draw fancy animation
    end

    if mode == "fancy" or mode == "minimal" then
        gl.ortho()
        gl.translate(WIDTH/2, HEIGHT/2)
        gl.scale(WIDTH * (1/aspect), HEIGHT)
        if fancy.fixaspect then
            fancy.fixaspect(aspect)
        end
    end
end

----------------------------------------------
return fancy

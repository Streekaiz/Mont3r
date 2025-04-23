local newVector2, newVector3, random, round, acos, cos = Vector2.new, Vector3.new, math.random, math.round, math.acos, math.cos
local library = {}

do -- // Math
    function library:roundVector(vector)
        return newVector2(round(vector.X), round(vector.Y))
    end

    function library:shift(number)
        return acos(cos(number * math.pi)) / math.pi
    end

    function library:random(number)
        return random(-number, number)
    end

    function library:randomVec3(x, y, z)
        return newVector3(
            library:random(x),
            library:random(y),
            library:random(z)
        )
    end
end

return library
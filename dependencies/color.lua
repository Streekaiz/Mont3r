local library = {}; do -- // Color
    function library:multiply(color, multiplier)
        return Color3.new(color.R * multiplier, color.G * multiplier, color.B * multiplier)
    end

    function library:add(color, addition)
        return Color3.new(color.R + addition, color.G + addition, color.B + addition)
    end

    function library:lerp(value, minColor, maxColor)
        if value <= 0 then 
            return maxColor 
        end
        if value >= 100 then 
            return minColor 
        end

        return Color3.new(
            maxColor.R + (minColor.R - maxColor.R) * value,
            maxColor.G + (minColor.G - maxColor.G) * value,
            maxColor.B + (minColor.B - maxColor.B) * value
        )
    end
end

return library
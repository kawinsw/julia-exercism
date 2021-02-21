RESISTOR_COLORS = Dict(
    "black" => 0, "brown" => 1, "red" => 2, "orange" => 3, "yellow" => 4, 
    "green" => 5, "blue" => 6, "violet" => 7, "grey" => 8, "white" => 9)

function label(colors)
    nums = [RESISTOR_COLORS[lowercase(color)] for color in colors]
    resistance = (nums[1] * 10 + nums[2]) * 10^nums[3]
    kilo = 1000
    if resistance % kilo == 0
        return "$(Int(resistance / kilo)) kiloohms"
    else
        return "$resistance ohms"
    end
end

ROMAN_CHARS = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]

function to_roman(number::Int)
    if number <= 0
        throw(ErrorException("Only positive integers can be represented by Roman numerals."))
    end

    roman_array = []
    n = number
    for (value, rep) in ROMAN_CHARS
        for _ in 1:Int(floor(n / value))
            push!(roman_array, rep)
        end
        n %= value
    end
    return join(roman_array)
end

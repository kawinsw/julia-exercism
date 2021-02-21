function luhn(input)
    numstring = replace(input, ' ' => "")
    len = lastindex(numstring)
    if len <= 1
        return false
    end
    odd = len % 2
    total = 0
    for (i, c) in enumerate(numstring)
        if !isdigit(c)
            return false
        end
        digit = c - '0'
        if i % 2 != odd
            double = digit * 2
            total += double
            if double > 9
                total -= 9
            end
        else
            total += digit
        end

    end
    return total % 10 == 0
end

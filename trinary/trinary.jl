function trinary_to_decimal(str)
    decimal = 0
    for c in str
        if '0' <= c <= '2'
            decimal = decimal * 3 + (c - '0')
        else
            return 0
        end
    end
    return decimal
end

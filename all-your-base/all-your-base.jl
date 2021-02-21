# Implement number base conversion

function all_your_base(digits, base_in, base_out)
    if base_in <= 1 || base_out <= 1
        throw(DomainError("base must be greater than 1"))
    end

    value = 0
    for d in digits
        if d < 0 || d >= base_in
            throw(DomainError("every digit d must be in {0, ..., base_in - 1}"))
        end
        value = value * base_in + d
    end
    
    if value == 0
        return [0]
    end

    output = []
    while value > 0
        value, d = divrem(value, base_out)
        push!(output, d)
    end
    return reverse(output)
end

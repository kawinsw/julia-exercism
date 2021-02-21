function prime_factors(input)
    output = []
    n = input
    for p in 2:isqrt(input)
        if n <= 1
            return output
        end

        while n % p == 0
            push!(output, p)
            n = div(n, p)
        end
    end
    if n > 1
        push!(output, n)
    end
    return output
end

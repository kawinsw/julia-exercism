function sieve(limit)
    primes = []
    markers = trues(limit)
    for i in 2:limit
        if markers[i]
            push!(primes, i)
            for j in 2*i:i:limit
                markers[j] = false
            end
        end
    end
    return primes
end

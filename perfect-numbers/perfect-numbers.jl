function isperfect(n)
    aliquot_sum(n) == n
end

function isabundant(n)
    aliquot_sum(n) > n
end

function isdeficient(n)
    aliquot_sum(n) < n
end

function aliquot_sum(n)
    supp = 1
    if n <= 0
        throw(DomainError("input must be a natural number"))
    elseif n == 1
        return 0
    end

    stop = isqrt(n)
    if stop ^ 2 == n
        supp -= stop
    end
    return supp + sum([i + div(n, i) for i in 2:stop if n % i == 0])
end
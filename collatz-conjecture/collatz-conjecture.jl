function collatz_steps(start::Int)
    if start < 1
        throw(DomainError("negative input"))
    end
    count = 0
    n = start
    while n > 1
        count += 1
        if n & 1 == 1
            n = 3 * n + 1
        else
            n = div(n, 2)
        end
    end
    return count
end
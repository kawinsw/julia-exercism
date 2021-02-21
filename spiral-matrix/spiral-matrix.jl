function spiral_matrix(n::Int)
    if n < 0
        throw(DomainError("matrix dimension must be non-negative"))
    end

    output = Array{Int}(undef, n, n)
    lim = n >> 1
    k = 1
    for i in 1:lim
        next = i + 1
        penultimate = n - i
        last = penultimate + 1
        for j in i:penultimate
            output[i, j] = k
            k += 1
        end
        for j in i:penultimate
            output[j, last] = k
            k += 1
        end
        for j in last:-1:next
            output[last, j] = k
            k += 1
        end
        for j in last:-1:next
            output[j, i] = k
            k += 1
        end
    end

    if n & 1 == 1
        lim += 1
        output[lim, lim] = k
    end
    return output
end

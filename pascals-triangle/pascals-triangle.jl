function triangle(n)
    if n < 0
        throw(DomainError("negative input"))
    elseif n == 0
        return []
    end

    prev = [1]
    pascal_triangle = [prev]
    for i = 2:n
        row = ones(i)
        for j = 2:(i - 1)
            row[j] = prev[j - 1] + prev[j]
        end
        push!(pascal_triangle, row)
        prev = row
    end
    
    return pascal_triangle
end

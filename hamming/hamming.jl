"Your optional docstring here"
function distance(a, b)
    count = 0
    len = length(a)
    if length(a) != length(b)
        throw(ArgumentError(b))
    end
    for (c, d) in zip(a, b)
        if c != d
            count += 1
        end
    end
    return count
end

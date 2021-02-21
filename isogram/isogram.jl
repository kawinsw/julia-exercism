function isisogram(s)
    seen = Set()
    for c in lowercase(s)
        if 'a' <= c <= 'z'
            if c in seen
                return false
            else
                push!(seen, c)
            end
        end
    end
    return true
end

"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""
function ispangram(input)
    alphabet_size = 26
    seen = Set()
    s = lowercase(input)
    for c in s
        if 'a' <= c <= 'z'
            push!(seen, c)
        end
    end
    return length(seen) == alphabet_size
end


function annotate(input)
    if isempty(input) || isempty(input[1])
        return copy(input)
    end
    num_rows = length(input)
    num_cols = length(input[1])
    tally = Array{Any}(undef, num_rows + 2, num_cols + 2)
    fill!(tally, 0)
    for (i, str) in enumerate(input)
        for (j, c) in enumerate(str)
            c == '*' || continue
            for p in i:(i+2), q in j:(j+2)
                tally[p, q] += 1
            end
        end
    end
    
    for (i, str) in enumerate(input)
        for (j, c) in enumerate(str)
            c == '*' && (tally[i+1, j+1] = '*')
        end
    end

    last = num_cols + 1
    return [replace(join(tally[i, 2:last]), '0' => ' ') for i in 2:(num_rows+1)]
end
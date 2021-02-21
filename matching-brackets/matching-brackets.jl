function matching_brackets(input)
    fringe = []
    for c in input
        if c == '('
            push!(fringe, ')')
        elseif c == '[' || c == '{'
            push!(fringe, Char(c + 2))
        elseif (c == ')' || c == ']' || c == '}') && (isempty(fringe) || pop!(fringe) != c)
            return false
        end
    end
    return isempty(fringe)
end
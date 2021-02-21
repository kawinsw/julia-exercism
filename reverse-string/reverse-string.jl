using Unicode

function myreverse(input)
    return string(reverse(collect(graphemes(input)))...)
end

function wordcount(sentence)
    arr = split(lowercase(sentence), r"[^a-z0-9']", keepempty=false)
    tally = Dict()
    for word in arr
        key = strip(word, '\'')
        if !isempty(key)
            tally[key] = get(tally, key, 0) + 1
        end
    end
    return tally
end

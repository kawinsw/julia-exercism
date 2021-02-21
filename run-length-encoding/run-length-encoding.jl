function encode(s)
    if isempty(s)
        return s
    end
    cipher_arr = []
    prev = s[1]
    count = 1
    for letter in s[nextind(s, 1):end]
        if letter == prev
            count += 1
            continue
        end
        count > 1 && push!(cipher_arr, count)
        push!(cipher_arr, prev)
        prev = letter
        count = 1
    end
    count > 1 && push!(cipher_arr, count)
    push!(cipher_arr, prev)
    return join(cipher_arr)
end

function decode(s)
    if isempty(s)
        return s
    end
    counts = split(replace(s, r"[^0-9]" => '\0'), '\0', keepempty=false)
    letters = split(replace(s, r"[0-9]" => '\0'), '\0', keepempty=false)
    length(letters) > length(counts) && pushfirst!(counts, "1")
    plain_arr = []
    for (count, letter_cluster) in zip(counts, letters)
        for _ in 1:parse(Int64, string(count))
            push!(plain_arr, letter_cluster[1])
        end
        push!(plain_arr, letter_cluster[nextind(letter_cluster, 1):end])
    end
    return join(plain_arr)
end

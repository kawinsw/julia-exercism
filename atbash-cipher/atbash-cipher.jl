function encode(input)
    return rstrip(join([space5(i, c) for (i, c) in enumerate(atbash_arr(input))]))
end

function decode(input)
    return join(atbash_arr(input))
end

function atbash_arr(input)
    s = replace(lowercase(input), r"[^a-z0-9]" => "")
    return [cipher_func(c) for c in collect(s)]
end

function cipher_func(c)
    if 'a' <= c <= 'z'
        return Char(Int('z') + Int('a') - Int(c))
    else
        return c
    end
end

function space5(i, c)
    if i % 5 == 0
        return string(c, ' ')
    else
        return c
    end
end
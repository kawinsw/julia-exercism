function rotate(n::Int, s::AbstractString)
    rfunc = make_rotation_cipher(n)
    return string([rfunc(c) for c in collect(s)]...)
end

function rotate(n::Int, c::AbstractChar)
    return make_rotation_cipher(n)(c)
end

function make_rotation_cipher(n)
    alphabet_size = 26
    function f(c)
        if 'A' <= c <= 'Z'
            return Char((c - 'A' + n) % alphabet_size + 'A')
        elseif 'a' <= c <= 'z'
            return Char((c - 'a' + n) % alphabet_size + 'a')
        else
            return c
        end
    end
    return f
end
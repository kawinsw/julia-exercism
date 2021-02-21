function secret_handshake(code)
    secret_array = ["wink", "double blink", "close your eyes", "jump"]
    seq = []
    for (i, action) in enumerate(secret_array)
        if ((code >> (i - 1)) & 1) == 1
            push!(seq, action)
        end
    end
    ((code >> 4) & 1) == 1 ? reverse(seq) : seq
end

function isarmstrong(n)
    arr = collect(string(n))
    num_digits = length(arr)
    total = sum([(c - '0') ^ num_digits for c in arr])
    return n == total
end
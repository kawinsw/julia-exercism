function pythagorean_triplets(n::Int)
    """
    To solve:               i^2 + j^2 = (n-i-j)^2               (eqn1)
    For each i, we have:    j = { n-i - [i^2 / (n-i)] } / 2
    For uniqueness, impose i < j since i and j are symmetric in eqn1
    i_max (= j_min) is given by:    2 * i_max^2 = (n - 2*i_max) ^ 2
    Solving, we have:               i <= n - n / sqrt(2) <= j
    """

    output = []
    for i in 1:floor(Int, n - n / sqrt(2))
        # for each possible i, compute j if an integer solution exists
        n_minus_i = n - i
        quot, rem = divrem(i*i, n_minus_i)
        if rem != 0
            continue
        end
        double_j = n_minus_i - quot
        if iseven(double_j)
            j = double_j >> 1
            push!(output, (i, j, n_minus_i - j))
        end
    end
    return output
end

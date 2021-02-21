function score(x, y)
    r_sq = x ^ 2 + y ^ 2
    if r_sq <= 1
        return 10
    elseif r_sq <= 25
        return 5
    elseif r_sq <= 100
        return 1
    else
        return 0
    end
end

"""Calculate the number of grains on square `square`."""
function on_square(square)
    check_valid_square(square)
    UInt128(1) << (square - 1)
end

"""Calculate the total number of grains after square `square`."""
function total_after(square)
    check_valid_square(square)
    (UInt128(1) << square) - 1
end

function check_valid_square(n)
    if n <= 0 || n > 64
        throw(DomainError("$n is not a valid square"))
    end
    return nothing
end
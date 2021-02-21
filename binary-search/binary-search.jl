function binarysearch(arr, target; by=nothing, lt=nothing, rev=false)
    if isempty(arr)
        return 1:0
    end
    if isnothing(lt)
        lt = (x, y) -> x < y
    end
    if isnothing(by)
        arr = by.(arr)
        target = by(target)
    end
    if rev
        arr = reverse(arr)
    end

    hi = length(arr) + 1
    lo = 1
    while lo + 1 < hi
        mid = Int(floor((lo + hi) / 2))
        if lt(target, arr[mid])
            hi = mid
        else
            lo = mid
        end
    end

    if lt(target, arr[lo])
        hi = lo - 1
    elseif lt(arr[lo], target)
        hi = lo
        lo = lo + 1
    else
        hi = lo
    end

    if rev
        len = length(arr) + 1
        return (len - hi):(len - lo)
    else
        return lo:hi
    end
end
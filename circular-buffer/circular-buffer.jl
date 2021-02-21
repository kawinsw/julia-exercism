mutable struct CircularBuffer{T} <: AbstractVector{T}
    arr::Vector{T}
    start::Integer
    numel::Integer

    function CircularBuffer{T}(capacity::Integer) where {T}
        new(Vector{T}(undef, capacity), 1, 0)
    end
end

Base.eltype(cb::CircularBuffer) = eltype(cb.arr)

capacity(cb::CircularBuffer) = length(cb.arr)
Base.length(cb::CircularBuffer) = cb.numel
Base.size(cb::CircularBuffer) = (length(cb),)
Base.isempty(cb::CircularBuffer) = length(cb) == 0
isfull(cb::CircularBuffer) = length(cb) == capacity(cb)

firstInd(cb::CircularBuffer) = cb.start
function findInd(cb::CircularBuffer, i::Integer)
    mod1(firstInd(cb) + i - 1, capacity(cb))
end
lastInd(cb::CircularBuffer) = findInd(cb, length(cb))

function Base.push!(cb::CircularBuffer, item; overwrite::Bool=false)
    typeof(item) <: eltype(cb)  || throw(ErrorException("invalid item type"))
    if isfull(cb)
        overwrite || throw(BoundsError("buffer is full"))
        cb.start = mod1(firstInd(cb) + 1, capacity(cb))
    else
        cb.numel += 1
    end
    cb.arr[lastInd(cb)] = item
    return cb
end

function Base.pop!(cb::CircularBuffer)
    length(cb) > 0 || throw(BoundsError("buffer is empty"))
    retval = cb.arr[lastInd(cb)]
    cb.numel -= 1
    return retval
end

function Base.pushfirst!(cb::CircularBuffer, item; overwrite::Bool=false)
    typeof(item) <: eltype(cb)  || throw(ErrorException("invalid item type"))
    if isfull(cb)
        overwrite || throw(BoundsError("buffer is full"))
    else
        cb.numel += 1
    end
    cb.start = mod1(firstInd(cb) - 1, capacity(cb))
    cb.arr[firstInd(cb)] = item
    return cb
end

function Base.popfirst!(cb::CircularBuffer)
    length(cb) > 0 || throw(BoundsError("buffer is empty"))
    retval = cb.arr[firstInd(cb)]
    cb.start = mod1(firstInd(cb) + 1, capacity(cb))
    cb.numel -= 1
    return retval
end

function Base.empty!(cb::CircularBuffer)
    cb.numel = 0
    return cb
end

function Base.append!(cb::CircularBuffer, arr; overwrite::Bool=false)
    numadd = length(arr)
    numbef = length(cb)
    numaft = numbef + numadd
    cap = capacity(cb)
    if numaft > cap
        overwrite || throw(BoundsError("exceeds buffer capacity"))
        cb.numel = cap
        if numadd >= cap
            cb.arr = copy(arr[end-cap+1:end])
            cb.start = 1
            return nothing
        else
            cb.start = findInd(cb, numaft - cap + 1)
        end
    else
        cb.numel = numaft
    end
    lastbef = lastInd(cb)
    rem = cap - lastbef
    if numadd <= rem
        cb.arr[lastbef+1:lastbef+numadd] = arr
    else
        cb.arr[lastbef+1:end] = arr[1:rem]
        cb.arr[1:numadd-rem] = arr[rem+1:end]
    end
    return nothing
end

function getat(cb::CircularBuffer, k::Integer)
    1 <= k || throw(BoundsError("index must be positive"))
    k <= length(cb) || throw(BoundsError("index exceeds buffer length"))
    return cb.arr[findInd(cb, k)]
end

function Base.getindex(cb::CircularBuffer, key...)
    length(key) > 1 && throw(BoundsError("buffer has only 1 dimension"))
    if typeof(key[1]) <: AbstractArray
        return [getat(cb, k) for k in key[1]]
    else
        return getat(cb, key[1])
    end
end

function setat(cb::CircularBuffer, value, k::Integer)
    1 <= k || throw(BoundsError("index must be positive"))
    k <= length(cb) || throw(BoundsError("index exceeds buffer length"))
    cb.arr[findInd(cb, k)] = value
    return nothing
end

function Base.setindex!(cb::CircularBuffer, value, key...)
    length(key) > 1 && throw(BoundsError("buffer has only 1 dimension"))
    if typeof(key[1]) <: AbstractArray
        for k in key[1]
            setat(cb, value, k)
        end
    else
        setat(cb, value, key[1])
    end
    return nothing
end

function Base.first(cb::CircularBuffer)
    isempty(cb) && throw(BoundsError("buffer is empty"))
    return cb.arr[firstInd(cb)]
end

function Base.last(cb::CircularBuffer)
    isempty(cb) && throw(BoundsError("buffer is empty"))
    return cb.arr[lastInd(cb)]
end

# Base.collect(cb::CircularBuffer) = convert(Array, cb)

function Base.convert(::Type{Array}, cb::CircularBuffer)
    last = firstInd(cb) + length(cb) - 1
    cap = capacity(cb)
    if last <= cap
        return copy(cb.arr[firstInd(cb):last])
    else
        return vcat(cb.arr[firstInd(cb):end], cb.arr[1:last - cap])
    end
end

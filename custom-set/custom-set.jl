mutable struct CustomSet{T} <: AbstractSet{T}
    arr::Vector{T}
    CustomSet() = new{Any}([])
    CustomSet(input) = new{Any}(vec(collect(input)))
end

function Base.isempty(cs::CustomSet)
    return isempty(cs.arr)
end

function Base.in(item, cs::CustomSet)
    for elem in cs.arr
        if item == elem
            return true
        end
    end
    return false
end

function Base.copy(cs::CustomSet)
    CustomSet(cs)
end

function Base.iterate(cs::CustomSet)
    iterate(cs.arr)
end

function Base.iterate(cs::CustomSet, i::Int)
    iterate(cs.arr, i)
end

function Base.length(cs::CustomSet)
    length(cs.arr)
end

function Base.issubset(subcs::CustomSet, supercs::CustomSet)
    for elem in subcs
        if !(elem in supercs)
            return false
        end
    end
    return true
end

function Base.:(==)(cs1::CustomSet, cs2::CustomSet)
    length(cs1) == length(cs2) && issubset(cs1, cs2)
end

function disjoint(cs1::CustomSet, cs2::CustomSet)
    for elem in cs1
        if elem in cs2
            return false
        end
    end
    return true
end

function Base.push!(cs::CustomSet, elem)
    if !(elem in cs)
        push!(cs.arr, elem)
    end
end

function Base.collect(cs::CustomSet)
    collect(cs.arr)
end

function intersect_array(cs1::CustomSet, cs2::CustomSet)
    overlap = []
    for elem in cs1
        if elem in cs2
            push!(overlap, elem)
        end
    end
    return overlap
end

function Base.intersect(cs1::CustomSet, cs2::CustomSet)
    CustomSet(intersect_array(cs1, cs2))
end

function Base.intersect!(cs1::CustomSet, cs2::CustomSet)
    cs1.arr = intersect_array(cs1, cs2)
    return nothing
end

function union_array(cs1::CustomSet, cs2::CustomSet)
    aggregate = collect(cs1)
    for elem in cs2
        if !(elem in cs1)
            push!(aggregate, elem)
        end
    end
    return aggregate
end

function Base.union(cs1::CustomSet, cs2::CustomSet)
    CustomSet(union_array(cs1, cs2))
end

function Base.union!(cs1::CustomSet, cs2::CustomSet)
    cs1.arr = union_array(cs1, cs2)
    return nothing
end

function complement_array(cs1::CustomSet, cs2::CustomSet)
    diff = []
    for elem in cs1
        if !(elem in cs2)
            push!(diff, elem)
        end
    end
    return diff
end

function complement(cs1::CustomSet, cs2::CustomSet)
    CustomSet(complement_array(cs1, cs2))
end

function complement!(cs1::CustomSet, cs2::CustomSet)
    cs1.arr = complement_array(cs1, cs2)
    return nothing
end
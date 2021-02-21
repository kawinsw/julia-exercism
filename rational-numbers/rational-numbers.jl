using Printf

struct RationalNumber{T <: Integer} <: Real
    nume::T
    denom::T
    function RationalNumber(n::T, d::T) where {T <: Integer}
        if n == d == 0
            throw(ArgumentError("0//0 is not allowed"))
        elseif d < 0
            d *= -1
            n *= -1
        end
        hcf = gcd(n, d)
        return new{T}(div(n, hcf), div(d, hcf))
    end
end

RationalNumber(n::T) where {T <: Integer}= RationalNumber(n, one(T))
RationalNumber(n::Integer, d::Integer) = RationalNumber(promote(n, d)...)
RationalNumber(q::RationalNumber) = RationalNumber(numerator(q), denominator(q))
function Base.zero(::Type{RationalNumber{T}}) where {T <: Integer}
    RationalNumber(zero(T))
end
function Base.one(::Type{RationalNumber{T}}) where {T <: Integer}
    RationalNumber(one(T))
end

Base.convert(::Type{T}, q::RationalNumber) where {T <: Number} = T(value(q))
function Base.convert(::Type{T}, q::RationalNumber) where {T <: Integer}
    if denominator(q) == 1
        return T(numerator(q))
    else
        throw(InexactError(Symbol(T), T, q))
    end
end
promote_rule(::Type{T}, ::Type{RationalNumber}) where {T <: Integer} = RationalNumber
promote_rule(::Type{T}, ::Type{RationalNumber}) where {T <: Number} = T

Base.numerator(q::RationalNumber) = q.nume
Base.denominator(q::RationalNumber) = q.denom
value(q::RationalNumber) = numerator(q) / denominator(q)

function Base.:(==)(a::RationalNumber, b::RationalNumber)
    numerator(a) == numerator(b) && denominator(a) == denominator(b)
end
Base.:(<)(a::RationalNumber, b::RationalNumber) = value(a) < value(b)
Base.:(<=)(a::RationalNumber, b::RationalNumber) = value(a) <= value(b)
Base.:(>)(a::RationalNumber, b::RationalNumber) = value(a) > value(b)
Base.:(>=)(a::RationalNumber, b::RationalNumber) = value(a) >= value(b)

Base.abs(q::RationalNumber) = RationalNumber(abs(numerator(q)), denominator(q))

Base.:+(a::RationalNumber, b::RationalNumber) = addsub(a, b, +)
Base.:-(a::RationalNumber, b::RationalNumber) = addsub(a, b, -)
function addsub(a::RationalNumber, b::RationalNumber, addsubfunc)
    a_denom = denominator(a)
    b_denom = denominator(b)
    hcf = gcd(a_denom, b_denom)
    b_d = div(b_denom, hcf)
    nume = addsubfunc(numerator(a) * b_d, numerator(b) * div(a_denom, hcf))
    return RationalNumber(nume, a_denom * b_d)
end

function Base.:*(a::RationalNumber, b::RationalNumber)
    mult_helper(numerator(a), denominator(a), numerator(b), denominator(b))
end

function Base.:/(a::RationalNumber, b::RationalNumber)
    if numerator(b) == 0
        return RationalNumber(0, 1)
    else
        return mult_helper(numerator(a), denominator(a), 
                           denominator(b), numerator(b))
    end
end

function mult_helper(a::Integer, b::Integer, c::Integer, d::Integer)
    # (a//b) * (c//d)
    a, d = factor_xor(a, d)
    b, c = factor_xor(b, c)
    return RationalNumber(a * c, b * d)
end

function factor_xor(m::Integer, n::Integer)
    hcf = gcd(m, n)
    return (div(m, hcf), div(n, hcf))
end

function Base.:^(q::RationalNumber, n::Integer)
    if n < 0
        return RationalNumber(denominator(q) ^ n, numerator(q) ^ n)
    else
        return RationalNumber(numerator(q) ^ n, denominator(q) ^ n)
    end
end
Base.:^(q::RationalNumber, x::Real) = (numerator(q) ^ x) / (denominator(q) ^ x)
Base.:^(x::Real, q::RationalNumber) = x ^ value(q)

function Base.show(io::IO, q::RationalNumber) 
    @printf(io, "%d//%d", numerator(q), denominator(q))
end
function Base.show(io::IO, ::MIME"text/plain", q::RationalNumber)
    @printf(io, "%d//%d", numerator(q), denominator(q))
end

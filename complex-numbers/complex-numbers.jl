struct ComplexNumber<:Number
    reim::Vector{Real}
    ComplexNumber(re::Real, im::Real) = new([re, im])
end

ComplexNumber(re::Real) = ComplexNumber(re, 0)
ComplexNumber(cn::ComplexNumber) = ComplexNumber(cn.reim)
function ComplexNumber(components::Vector)
    if length(components) == 2
        ComplexNumber(components...)
    else
        throw(DomainError("complex numbers have exactly 2 components"))
    end
end

Base.real(cn::ComplexNumber)::Real = cn.reim[1]
Base.imag(cn::ComplexNumber)::Real = cn.reim[2]
Base.:(==)(a::ComplexNumber, b::ComplexNumber) = a.reim == b.reim
Base.isapprox(a::ComplexNumber, b::ComplexNumber) = isapprox(a.reim, b.reim)

Base.conj(cn::ComplexNumber)::ComplexNumber = ComplexNumber(real(cn), -imag(cn))
abs_sq(cn::ComplexNumber)::Real = sum(cn.reim .^ 2)
Base.abs(cn::ComplexNumber)::Real = sqrt(abs_sq(cn))
Base.isfinite(cn::ComplexNumber) = isfinite(real(cn)) && isfinite(imag(cn))

function Base.:+(a::ComplexNumber, b::ComplexNumber)::ComplexNumber
    ComplexNumber(a.reim + b.reim)
end

function Base.:-(a::ComplexNumber, b::ComplexNumber)::ComplexNumber
    ComplexNumber(a.reim - b.reim)
end

function Base.:*(a::ComplexNumber, b::ComplexNumber)::ComplexNumber
    pdt = a.reim .* b.reim
    return ComplexNumber(pdt[1] - pdt[2], imag(a) * real(b) + real(a) * imag(b))
end

function Base.:/(a::ComplexNumber, b::ComplexNumber)::ComplexNumber
    denom = abs_sq(b)
    return ComplexNumber( sum(a.reim .* b.reim) / denom,
                          ( imag(a) * real(b) - real(a) * imag(b) ) / denom )
end

function reciprocal(cn::ComplexNumber)::ComplexNumber
    denom = abs_sq(cn)
    return ComplexNumber(real(cn) / denom, -imag(cn) / denom)
end

function Base.:^(cn::ComplexNumber, n::Integer)::ComplexNumber
    if n < 0
        return reciprocal(cn) ^ (-n)
    end
    output = ComplexNumber(1)
    factor = ComplexNumber(cn)
    expo = n
    while expo > 0
        if expo & 1 == 1
            output *= factor
        end
        factor *= factor
        expo >>= 1
    end
    return output
end

function Base.exp(cn::ComplexNumber)
    mantissa = exp(real(cn))
    im = imag(cn)
    return ComplexNumber(mantissa * cos(im), mantissa * sin(im))
end

"""
struct ComplexNumber<:Number
    mag::Real
    phase::Real
    ComplexNumber( (r, theta)::Tuple{Real, Real} ) = new(r, theta)
end
ComplexNumber(cn::ComplexNumber) = ComplexNumber( ( abs(cn), angle(cn) ) )
function ComplexNumber(re::Real, im::Real)
    ComplexNumber( ( sqrt(re*re + im*im), atan(im, re) ) )
end
ComplexNumber(re::Real) = ComplexNumber( ( abs(re), re < 0 ? pi : 0 ) )

Base.abs(cn::ComplexNumber)::Real = cn.mag
angle(cn::ComplexNumber)::Real = cn.phase
Base.real(cn::ComplexNumber)::Real = abs(cn) * cos(angle(cn))
Base.imag(cn::ComplexNumber)::Real = abs(cn) * sin(angle(cn))

function Base.:(==)(a::ComplexNumber, b::ComplexNumber)
    real(a) == real(b) && imag(a) == imag(b)
end
function Base.:(==)(a::ComplexNumber, b::ComplexNumber)
    abs(a) == abs(b) && (abs(a) == 0 || mod2pi(angle(a)) == mod2pi(angle(b)))
end

conj(cn::ComplexNumber)::ComplexNumber = ComplexNumber( ( abs(cn), -angle(cn) ) )
Base.isfinite(cn::ComplexNumber) = isfinite(abs(cn)) && isfinite(angle(cn))

function Base.:+(a::ComplexNumber, b::ComplexNumber)::ComplexNumber
    ComplexNumber(real(a) + real(b), imag(a) + imag(b))
end

function Base.:-(a::ComplexNumber, b::ComplexNumber)::ComplexNumber
    ComplexNumber(real(a) - real(b), imag(a) - imag(b))
end

function Base.:*(a::ComplexNumber, b::ComplexNumber)::ComplexNumber
    ComplexNumber( ( abs(a) * abs(b), angle(a) + angle(b) ) )
end

function Base.:/(a::ComplexNumber, b::ComplexNumber)::ComplexNumber
    ComplexNumber( ( abs(a) / abs(b), angle(a) - angle(b) ) )
end

function Base.:^(cn::ComplexNumber, n::Integer)::ComplexNumber
    ComplexNumber( ( abs(cn) ^ n, angle(cn) * n ) )
end
"""

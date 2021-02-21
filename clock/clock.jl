using Printf: @printf

HOURS_PER_DAY = 24
MINUTES_PER_HOUR = 60
MAX_MINUTES = MINUTES_PER_HOUR * HOURS_PER_DAY - 1

struct Clock
    tmin::Int
    Clock(m::Int) = new(mod(m, 0:MAX_MINUTES))
end

Clock(h::Int, m::Int) = Clock(60*h + m)
Clock(t::Clock) = Clock(t.tmin)

hour(t::Clock) = div(t.tmin, MINUTES_PER_HOUR)
minute(t::Clock) = t.tmin % MINUTES_PER_HOUR
Base.:(==)(a::Clock, b::Clock) = a.tmin == b.tmin

function Base.show(io::IO, ::MIME"text/plain", t::Clock)
    @printf(io, "\"%02d%c%02d\"", hour(t), ':', minute(t))
end
function Base.show(io::IO, t::Clock)
    @printf(io, "\"%02d%c%02d\"", hour(t), ':', minute(t))
end

Base.:+(t::Clock, m::Dates.Minute) = Clock(t.tmin + Dates.value(m))
Base.:-(t::Clock, m::Dates.Minute) = Clock(t.tmin - Dates.value(m))

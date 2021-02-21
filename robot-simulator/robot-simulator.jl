mutable struct Robot
    coord::Vector{Real}
    face::Vector{Real}
    Robot(pos::Tuple{Real, Real}, dir::Tuple{Real, Real}) = new(collect(pos), collect(dir))
end

struct Point{T<:Real}
    x::T
    y::T
end

NORTH = (0, 1)
EAST = (1, 0)
SOUTH = (0, -1)
WEST = (-1, 0)

function position(r::Robot)
    return Point(r.coord...)
end

function heading(r::Robot)
    return Tuple(r.face)
end

function advance!(r::Robot)
    r.coord += r.face
    return r
end

function turn_left!(r::Robot)
    r.face = [-r.face[2], r.face[1]]
    return r
end

function turn_right!(r::Robot)
    r.face = [r.face[2], -r.face[1]]
    return r
end

function move!(r::Robot, input::AbstractString)
    for c in input
        if c == 'A'
            advance!(r)
        elseif c == 'L'
            turn_left!(r)
        elseif c == 'R'
            turn_right!(r)
        end
    end
    return r
end
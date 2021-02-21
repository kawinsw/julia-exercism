using Printf: @sprintf
using Random: rand, randstring

mutable struct Robot
    name::AbstractString
    Robot() = new(generate_robot_name())
end

function reset!(instance::Robot)
    instance.name = generate_robot_name()
end

function name(instance::Robot)
    instance.name
end

USED_ROBOT_NAMES = Set()
function generate_robot_name()
    cand = random_robot_name()
    while cand in USED_ROBOT_NAMES
        cand = random_robot_name()
    end
    push!(USED_ROBOT_NAMES, cand)
    return cand
end

function random_robot_name()
    letters = randstring('A':'Z', 2)
    num = rand(0:999)
    return @sprintf("%s%03d", letters, num)
end
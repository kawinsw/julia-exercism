using Random

function modifier(ability)
    Int(fld((ability - 10), 2))
end

function ability()
    dice = rand(1:6, 4)
    return sum(dice) - minimum(dice)
end

mutable struct DNDCharacter
    strength::Int
    dexterity::Int
    constitution::Int
    intelligence::Int
    wisdom::Int
    charisma::Int
    hitpoints::Int

    function DNDCharacter()
        state = [ability() for _ in 1:6]
        push!(state, 10 + modifier(state[3]))
        return new(state...)
    end
end

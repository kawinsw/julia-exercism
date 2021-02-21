function transform(input::AbstractDict)
    letter_to_score = Dict()
    for (score, letters) in input
        for c in letters
            letter_to_score[lowercase(c)] = score
        end
    end
    return letter_to_score
end

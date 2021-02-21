function raindrops(number)
    results = []
    if number % 3 == 0
        push!(results, "Pling")
    end
    if number % 5 == 0
        push!(results, "Plang")
    end
    if number % 7 == 0
        push!(results, "Plong")
    end
    if isempty(results)
        return string(number)
    else
        return join(results)
    end
end

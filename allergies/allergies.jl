ALLERGY_CODES = Dict(allergen => i - 1 for (i, allergen) in enumerate(
    ["eggs", "peanuts", "shellfish", "strawberries", 
    "tomatoes", "chocolate", "pollen", "cats"]))

function allergic_to(score, allergen)
    ((score >> ALLERGY_CODES[allergen]) & 1) == 1
end

function allergy_list(score)
    Set([allergen for (allergen, i) in ALLERGY_CODES if ((score >> i) & 1) == 1])
end

not_letter(c) = c < 'A' || c > 'Z'

function acronym(phrase)
    String(map(word -> lstrip(not_letter, word)[1], split(uppercase(phrase), [' ', '-'], keepempty=false)))
end
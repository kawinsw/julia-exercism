SCRABBLE_ARRAY = [(1, ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T']),
                  (2, ['D', 'G']),
                  (3, ['B', 'C', 'M', 'P']),
                  (4, ['F', 'H', 'V', 'W', 'Y']),
                  (5, ['K']),
                  (8, ['J', 'X']),
                  (10, ['Q', 'Z'])]
SCRABBLE_POINTS = Dict()
for (val, letters) in SCRABBLE_ARRAY
    for letter in letters
        SCRABBLE_POINTS[letter] = val
    end
end

function score(str)
    isempty(str) ? 0 : sum([get(SCRABBLE_POINTS, c, 0) for c in uppercase(str)])
end

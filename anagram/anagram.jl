function detect_anagrams(subject, candidates)
    anagrams = []
    isanagram = make_anagram_checker(subject)
    for s in candidates
        if isanagram(s)
            push!(anagrams, s)
        end
    end
    return anagrams
end

function make_anagram_checker(subject)
    base = lowercase(subject)
    subject_letters = tally_letters(base)
    return cand -> (subject_letters == tally_letters(cand) && lowercase(cand) != base)
end

function tally_letters(s)
    zero = 'a' - 1
    alphabet_size = 26
    tally = zeros(alphabet_size)
    for c in lowercase(s)
        if 'a' <= c <= 'z'
            tally[c - zero] += 1
        end
    end
    return tally
end

rna_mapping = Dict('A' => 'U', 'C' => 'G', 'G' => 'C', 'T' => 'A')
function rna_map_func(c) 
    if haskey(rna_mapping, c)
        return rna_mapping[c]
    else
        throw(ErrorException("invalid input"))
    end
end

function to_rna(dna)
    string(map(rna_map_func, collect(dna))...)
end
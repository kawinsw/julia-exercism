"""
    count_nucleotides(strand)

The frequency of each nucleotide within `strand` as a dictionary.

Invalid strands raise a `DomainError`.

"""
function count_nucleotides(strand)
    tally = Dict('A' => 0, 'C' => 0, 'G' => 0, 'T' => 0)
    for c in strand
        if haskey(tally, c)
            tally[c] += 1
        else
            throw(DomainError(c))
        end
    end
    tally
end

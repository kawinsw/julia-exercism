struct ISBN <: AbstractString
    function ISBN(str::String)
        if isvalid(ISBN, str)
            return replace(str, '-' => "")
        else
            throw(DomainError("invalid ISBN"))
        end
    end
end

macro isbn_str(s) ISBN(s) end

function isvalid(::Type{ISBN}, input::String)
    carr = collect(replace(input, '-' => ""))
    if length(carr) != 10
        return false
    end
    
    total = 0
    for i in 1:9
        if !isdigit(carr[i])
            return false
        end
        total += (carr[i] - '0') * (11 - i)
    end
    
    if carr[10] == 'X'
        total += 10
    elseif isdigit(carr[10])
        total += carr[10] - '0'
    else
        return false
    end
    
    return total % 11 == 0
end

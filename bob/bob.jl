function bob(stimulus)
    str = rstrip(stimulus)
    if str == ""
        return "Fine. Be that way!"
    end
    is_question = str[end] == '?'
    if all_uppercase(str)
        if is_question
            return "Calm down, I know what I'm doing!"
        else
            return "Whoa, chill out!"
        end
    elseif is_question
        return "Sure."
    else
        return "Whatever."
    end
end

function all_uppercase(s)
    if s != uppercase(s)
        return false
    end
    for c in s
        if 'A' <= c <= 'Z'
            return true
        end
    end
    return false
end

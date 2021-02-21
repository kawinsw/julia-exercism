function clean(phone_number)
    isempty(replace(phone_number, r"[^A-Za-z]" => "")) || return nothing

    digits = replace(phone_number, r"[^0-9]" => "")
    len = length(digits)
    if len == 11
        if digits[1] == '1'
            digits = digits[2:end]
        else
            return nothing
        end
    elseif len != 10
        return nothing
    end

    if digits[1] == '0' || digits[1] == '1' || digits[4] == '0' || digits[4] == '1'
        return nothing
    else
        return digits
    end
end

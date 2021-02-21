"""
    is_leap_year(year)

Return `true` if `year` is a leap year in the gregorian calendar.

"""
function is_leap_year(year)
    if year % 400 == 0
        return true
    elseif year % 100 == 0
        return false
    else
        return year % 4 == 0
    end
end


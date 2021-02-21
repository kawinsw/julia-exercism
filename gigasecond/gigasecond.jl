function add_gigasecond(date::DateTime)
    return date + Second(10 ^ 9)
end

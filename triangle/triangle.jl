is_equilateral(sides) = is_triangle_category(sides,
    arr -> arr[1] == arr[2] == arr[3])

is_isosceles(sides) = is_triangle_category(sides,
    ordered -> ordered[1] == ordered[2] || ordered[2] == ordered[3])

is_scalene(sides) = is_triangle_category(sides,
    ordered -> ordered[1] < ordered[2] < ordered[3])

function is_triangle_category(sides, category_func)
    length(sides) == 3 || return false
    ordered = sort(sides)
    return ordered[1] > 0 && ordered[1] + ordered[2] >= ordered[3] && category_func(ordered)
end

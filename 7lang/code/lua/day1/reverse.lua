function reverse(s, t)
    if #s < 1 then return t end
    first = string.sub(s, 1, 1)
    rest  = string.sub(s, 2, -1)
    return reverse(rest, first .. t)
end

large = string.rep('hello ', 5000)
print(reverse(large, ''))

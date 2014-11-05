function factorial(num, product)
    if num <= 1 then return product end
    return factorial(num - 1, num * product)
end

factorial(5, 1)     -- 120
factorial(50000, 1) -- inf

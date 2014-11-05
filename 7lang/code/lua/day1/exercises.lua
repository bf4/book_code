function ends_in_3(num)
    return num % 10 == 3
end

print(ends_in_3(42))
print(ends_in_3(43))
print('---')

function is_prime(num)
    for i = 2, num - 1 do
       if num % i == 0 then
           return false
       end
    end

    return true
end

print(is_prime(10))
print(is_prime(11))
print('---')

function print_first_n_primes_ending_in_3(n)
   local candidate = 3
   local found     = 0

   while found < n do
      if ends_in_3(candidate) and is_prime(candidate) then
         print(candidate)
         found = found + 1
      end

      candidate = candidate + 1
   end
end

print_first_n_primes_ending_in_3(10)
print('---')

function for_loop(a, b, f)
    local i = a
    while i <= b do
       f(i)
       i = i + 1
    end
end

for_loop(10, 20, function(n)
    print(n * 2)
end)
print('---')

function reduce(max, init, f)
    local intermediate = init

    for i = 1, max do
        intermediate = f(intermediate, i)
    end

    return intermediate
end

print(reduce(5, 0, function(a, b) return a + b end))
print('---')

function factorial(n)
    return reduce(n, 1, function(a, b) return a * b end)
end

print(factorial(6))

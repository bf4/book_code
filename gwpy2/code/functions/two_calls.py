def f(x):
    x = 2 * x
    return x

x = 1
x = f(x + 1) + f(x + 2)
print(x)

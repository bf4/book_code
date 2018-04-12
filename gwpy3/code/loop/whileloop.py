time = 0
population = 1000   # 1000 bacteria to start with
growth_rate = 0.21 # 21% growth per minute
while population < 2000:
    population = population + growth_rate * population
    print(round(population))
    time = time + 1
	
print("It took", time, "minutes for the bacteria to double.")
print("The final population was", round(population), "bacteria.")

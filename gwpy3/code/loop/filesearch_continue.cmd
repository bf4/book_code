entry_number = 1
file = open("planets.txt", "r")
for line in file :
    line = line.strip()
    if line.startswith("#"):
        continue
    if line == "Earth":
        break
    entry_number = entry_number + 1
print("Earth is the {}th-lightest planet.".format(entry_number))

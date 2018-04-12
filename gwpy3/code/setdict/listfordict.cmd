>>> observations_file = open('observations.txt')
>>> bird_counts = []                            
>>> for line in observations_file:              
...     bird = line.strip()                     
...     found = False
...     # Find bird in the list of bird counts.
...     for entry in bird_counts:
...         if entry[0] == bird:
...             entry[1] = entry[1] + 1
...             found = True
...     if not found:
...         bird_counts.append([bird, 1])
... 
>>> observations_file.close()
>>> for entry in bird_counts:
...     print(entry[0], entry[1])
... 
canada goose 5
long-tailed jaeger 2
snow goose 1
northern fulmar 1

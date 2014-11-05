>>> observations_file = open('observations.txt')
>>> bird_to_observations = {}
>>> for line in observations_file:
...     bird = line.strip()
...     if bird in bird_to_observations:
...         bird_to_observations[bird] = bird_to_observations[bird] + 1
...     else:
...         bird_to_observations[bird] = 1
... 
>>> observations_file.close()
>>> 
>>> # Print each bird and the number of times it was seen.
... for bird, observations in bird_to_observations.items():
...     print(bird, observations)
... 
snow goose 1
long-tailed jaeger 2
canada goose 5
northern fulmar 1

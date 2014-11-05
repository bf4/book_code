>>> observations_file = open('observations.txt')
>>> birds_observed = set()
>>> for line in observations_file:              
...     bird = line.strip()                     
...     birds_observed.add(bird)                
... 
>>> birds_observed
{'long-tailed jaeger', 'canada goose', 'northern fulmar', 'snow goose'}

>>> bird_to_observations = {'eagle': 999, 'snow goose': 33}
>>> 'eagle' in bird_to_observations
True
>>> if 'eagle' in bird_to_observations:
...   print('eagles have been seen')
...
eagles have been seen
>>> del bird_to_observations['eagle']
>>> 'eagle' in bird_to_observations
False
>>> if 'eagle' in bird_to_observations:
...   print('eagles have been seen')
...
>>>

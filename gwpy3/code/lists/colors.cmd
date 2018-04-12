>>> colors = ['red', 'orange', 'green']                 
>>> colors.extend(['black', 'blue'])
>>> colors                             
['red', 'orange', 'green', 'black', 'blue']
>>> colors.append('purple')            
>>> colors
['red', 'orange', 'green', 'black', 'blue', 'purple']
>>> colors.insert(2, 'yellow')         
>>> colors
['red', 'orange', 'yellow', 'green', 'black', 'blue', 'purple']
>>> colors.remove('black')                              
>>> colors
['red', 'orange', 'yellow', 'green', 'blue', 'purple']

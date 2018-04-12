>>> s = 'C3H7'                   
>>> total = 0                    
>>> count = 0                    
>>> for i in range(len(s)):      
...     if not s[i].isalpha():
...         total = total + int(s[i])
...         count = count + 1
... 
>>> total
10
>>> count
2

def bio(name, location, **details):
    print("I am %s from %s." % (name, location))
    for key in details.keys():
        print("My %s is %s." % (key, details[key]))

bio(name     = "Nick",
    location = "Minneapolis",
    drink    = "tea",
    quest    = "JRuby")

# Prints:
#   I am Nick from Minneapolis.
#   My quest is JRuby.
#   My drink is tea.

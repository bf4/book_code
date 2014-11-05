if ph_reliable and ph < 7.0:
    print(ph, "is acidic.")
elif ph_reliable and ph > 7.0:
    print(ph, "is basic.")
elif ph_reliable:
    print(ph, "is neutral.")
else:
    print("That pH reading isn't reliable!")

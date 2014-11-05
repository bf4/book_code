def get_weekday(current_weekday, days_ahead):
    return (current_weekday + days_ahead) % 7

def days_difference(day1, day2):
    return day2 - day1

def get_birthday_weekday(current_weekday, current_day, birthday_day):
    days_diff = days_difference(current_day, birthday_day)
    return get_weekday(current_weekday, days_diff)

which_day = get_birthday_weekday(5, 3, 116)
print(which_day)

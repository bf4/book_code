def get_weekday(current_weekday: int, days_ahead: int) -> int:
    """Return which day of the week it will be days_ahead days from
    current_weekday.

    current_weekday is the current day of the week and is in the range 1-7,
    indicating whether today is Sunday (1), Monday (2), ..., Saturday (7).

    days_ahead is the number of days after today.

    >>> get_weekday(3, 1)
    4
    >>> get_weekday(6, 1)
    7
    >>> get_weekday(7, 1)
    1
    >>> get_weekday(1, 0)
    1
    >>> get_weekday(4, 7)
    4
    >>> get_weekday(7, 72)
    2
    """

    return (current_weekday + days_ahead) % 7

def days_difference(day1: int, day2: int) -> int:
    """Return the number of days between day1 and day2, which are both
    in the range 1-365 (thus indicating the day of the year).

    >>> days_difference(200, 224)
    24
    >>> days_difference(50, 50)
    0
    >>> days_difference(100, 99)
    -1
    """

    return day2 - day1


def get_birthday_weekday(current_weekday: int, current_day: int, birthday_day: int):
    """Return the day of the week it will be on birthday_day, given that
    the day of the week is current_weekday and the day of the year is
    current_day.

    current_weekday is the current day of the week and is in the range 1-7,
    indicating whether today is Sunday (1), Monday (2), ..., Saturday (7).

    current_day and birthday_day are both in the range 1-365.

    >>> get_birthday_weekday(5, 3, 4)
    6
    >>> get_birthday_weekday(5, 3, 116)
    6
    >>> get_birthday_weekday(6, 116, 3)
    5
    """

    days_diff = days_difference(current_day, birthday_day)
    return get_weekday(current_weekday, days_diff)

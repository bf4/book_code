class Member:
    """ A member of a university. """

    def __init__(self, name: str, address: str, email: str) -> None:
        """Create a new member named name, with home address and email address.
        """

        self.name = name
        self.address = address
        self.email = email

class Faculty(Member):
    """ A faculty member at a university. """

    def __init__(self, name: str, address: str, email: str,
                 faculty_num: str) -> None:
        """Create a new faculty named name, with home address, email address,
        faculty number faculty_num, and empty list of courses.
        """

        super().__init__(name, address, email)
        self.faculty_number = faculty_num
        self.courses_teaching = []


class Student(Member):
    """ A student member at a university. """

    def __init__(self, name: str, address: str, email: str,
                 student_num: str) -> None:
        """Create a new student named name, with home address, email address,
        student number student_num, an empty list of courses taken, and an
        empty list of current courses.
        """

        super().__init__(name, address, email)
        self.student_number = student_num
        self.courses_taken = []
        self.courses_taking = []

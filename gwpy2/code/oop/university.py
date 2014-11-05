class Member:
    """ A member of a university. """

    def __init__(self, name, address, email):
        """ (Member, str, str, str) -> NoneType

        Create a new member named name, with home address and email address.
        """

        self.name = name
        self.address = address
        self.email = email

class Faculty(Member):
    """ A faculty member at a university. """

    def __init__(self, name, address, email, faculty_num):
        """ (Member, str, str, str, str) -> NoneType

        Create a new faculty named name, with home address, email address,
        faculty number faculty_num, and empty list of courses.
        """

        super().__init__(name, address, email)
        self.faculty_number = faculty_num
        self.courses_teaching = []

		
class Student(Member):
    """ A student member at a university. """

    def __init__(self, name, address, email, student_num):
        """ (Member, str, str, str, str) -> NoneType
		
        Create a new student named name, with home address, email address,
        student number student_num, an empty list of courses taken, and an
        empty list of current courses.
        """

        super().__init__(name, address, email)
        self.student_number = student_num
        self.courses_taken = []
        self.courses_taking = []

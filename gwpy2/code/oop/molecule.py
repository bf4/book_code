from atom import Atom

class Molecule:
    """A molecule with a name and a list of Atoms. """

    def __init__(self, name):
        """ (Molecule, str) -> NoneType
		
        Create a Molecule named name with no Atoms.
        """

        self.name = name
        self.atoms = []

    def add(self, a):
        """ (Molecule, Atom) -> NoneType
		
        Add a to my list of Atoms.
        """

        self.atoms.append(a)

    def translate(self, x, y, z):
        """ (Molecule, number, number, number) -> NoneType

        Move this Molecule, including all Atoms, by (x, y, z).
        """

        for atom in self.atoms:
            atom.translate(x, y, z)

    def __str__(self):
        """ (Molecule) -> str
		
        Return a string representation of this Molecule in this format:
            (NAME, (ATOM1, ATOM2, ...))
        """

        res = ''
        for atom in self.atoms:
            res = res + str(atom) + ', '
			
        # Strip off the last comma.
        res = res[:-2]
        return '({0}, ({1}))'.format(self.name, res)

    def __repr__(self):
        """ (Molecule) -> str

        Return a string representation of this Molecule in this format:
          Molecule("NAME", (ATOM1, ATOM2, ...))
        """

        res = ''
        for atom in self.atoms:
            res = res + repr(atom) + ', '
			
        # Strip off the last comma.
        res = res[:-2]
        return 'Molecule("{0}", ({1}))'.format(self.name, res)


if __name__ == '__main__':
    ammonia = Molecule("AMMONIA")
    ammonia.add(Atom(1, "N", 0.257, -0.363, 0.0))
    ammonia.add(Atom(2, "H", 0.257, 0.727, 0.0))
    ammonia.add(Atom(3, "H", 0.771, -0.727, 0.890))
    ammonia.add(Atom(4, "H", 0.771, -0.727, -0.890))
    ammonia.translate(0, 0, 0.2)
    assert ammonia.atoms[0].center[0] == 0.257
    assert ammonia.atoms[0].center[1] == -0.363
    assert ammonia.atoms[0].center[2] == 0.2
    print repr(ammonia)
    print ammonia

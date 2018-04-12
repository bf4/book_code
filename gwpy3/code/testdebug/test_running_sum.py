import unittest
import sums as sums

class TestRunningSum(unittest.TestCase):
    """Tests for sums.running_sum."""

    def test_running_sum_empty(self):
        """Test an empty list."""

        argument = []
        expected = []
        sums.running_sum(argument)
        self.assertEqual(expected, argument, "The list is empty.")

    def test_running_sum_one_item(self):
        """Test a one-item list."""

        argument = [5]
        expected = [5]
        sums.running_sum(argument)
        self.assertEqual(expected, argument, "The list contains one item.")

    def test_running_sum_two_items(self):
        """Test a two-item list."""

        argument = [2, 5]
        expected = [2, 7]
        sums.running_sum(argument)
        self.assertEqual(expected, argument, "The list contains two items.")

    def test_running_sum_multi_negative(self):
        """Test a list of negative values."""

        argument = [-1, -5, -3, -4]
        expected = [-1, -6, -9, -13]
        sums.running_sum(argument)
        self.assertEqual(expected, argument,
            "The list contains only negative values.")

    def test_running_sum_multi_zeros(self):
        """Test a list of zeros."""

        argument = [0, 0, 0, 0]
        expected = [0, 0, 0, 0]
        sums.running_sum(argument)
        self.assertEqual(expected, argument, "The list contains only zeros.")

    def test_running_sum_multi_positive(self):
        """Test a list of positive values."""

        argument = [4, 2, 3, 6]
        expected = [4, 6, 9, 15]
        sums.running_sum(argument)
        self.assertEqual(expected, argument,
            "The list contains only positive values.")

    def test_running_sum_multi_mix(self):
        """Test a list containing mixture of negative values, zeros and
        positive values."""

        argument = [4, 0, 2, -5, 0]
        expected = [4, 4, 6, 1, 1]
        sums.running_sum(argument)
        self.assertEqual(expected, argument,
            "The list contains a mixture of negative values, zeros and"
                         + "positive values.")

unittest.main()

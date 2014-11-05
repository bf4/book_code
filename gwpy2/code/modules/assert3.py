import nose
from temp_with_doc import to_celsius
def test_to_celsius():
    '''Test function for to_celsius'''
    assert to_celsius(100) == 37.8, 'Returning an unrounded result'
if __name__ == '__main__':
    nose.runmodule()

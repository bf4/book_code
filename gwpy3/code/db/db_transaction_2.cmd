cur.execute('SELECT SignedOut FROM Books WHERE ISBN = ?', isbn)
signedOut = cur.fetchone()[0]
cur.execute('''UPDATE Books SET SignedOut = ? 
               WHERE ISBN = ?''', signedOut - 1, isbn)
cur.commit()

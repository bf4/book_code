Computer A: cur.execute('SELECT SignedOut FROM Books WHERE ISBN = ?', isbn)
Computer A: signedOut = cur.fetchone()[0]
Computer B: cur.execute('SELECT SignedOut FROM Books WHERE ISBN = ?', isbn)
Computer B: signedOut = cur.fetchone()[0]
Computer A: cur.execute('''UPDATE Books SET SignedOut = ? 
                           WHERE ISBN = ?''', signedOut + 1, isbn)
Computer A: cur.commit()
Computer B: cur.execute('''UPDATE Books SET SignedOut = ? 
                           WHERE ISBN = ?''', signedOut - 1, isbn)
Computer B: cur.commit()

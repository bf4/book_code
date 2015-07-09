/***
 * Excerpted from "Secure Your Node.js Web Application",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/kdnodesec for more book information.
***/
// First we start the transaction
connection.beginTransaction(function(err) {
    if (err) {
        next(err);
        return;
    }
    // Then we remove items from warehouse
    var warehouseSql = 'UPDATE warehouse SET quantity = quantity - ? ' +
        'WHERE quantity >= ? AND id = ?';

    connection.query(warehouseSql, [quantity, quantity, productId],
        function(wErr, result) {
            if (wErr) {
                // Unsuccessful so rollback
                connection.rollback(function() {
                    next(wErr);
                });
                return;
            }

            if(result.changedRows !== 1) { // Not enough items in warehouse
                connection.rollback(function() {
                    res.send(400, 'Insufficient funds');
                });
                return;
            }

            // Add items to cart
            var cartSql = 'UPDATE wallets ' +
                'SET amount = amount - ? WHERE amount >= ? AND name = ?';

            connection.query(cartSql, [amount, amount, name],
                function(cErr) {
                    if (cErr) {
                        // Unsuccessful so rollback
                        connection.rollback(function() {
                            next(cErr);
                        });
                        return;
                    }
                    // We have updated both so commit the result
                    connection.commit(function(commitErr) {
                        if (commitErr) {
                            connection.rollback(function() {
                                next(commitErr);
                            });
                            return;
                        }
                        // Everything went successfully
                        res.send(200);
                    });
                });
        });
});
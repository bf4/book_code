>>> import book
>>> ruby_book = book.Book()
>>> ruby_book.title = 'Programming Ruby'
>>> ruby_book.authors = ['Thomas', 'Fowler', 'Hunt']
>>> book.Book.num_authors(ruby_book)
3
>>> ruby_book.num_authors()
3
>>> Book.num_authors(ruby_book)
3
>>> ruby_book.num_authors()
3

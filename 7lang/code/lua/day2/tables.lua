-- START:constructor
book = {
   title  = "Grail Diary",
   author = "Henry Jones",
   pages  = 100
}
-- END:constructor

-- START:read
print(book.title) --> Grail Diary
-- END:read

-- START:modify
book.stars  = 5
book.author = "Henry Jones, Sr."
-- END:modify

-- START:print_table
print_table(book) --> stars: 5
                  --> author: Henry Jones, Sr.
                  --> title: Grail Diary
                  --> pages: 100
-- END:print_table

-- START:delete
book.pages = nil

print_table(book) --> stars: 5
                  --> author: Henry Jones, Sr.
                  --> title: Grail Diary
-- END:delete

-- START:key
key = "title"
=book[key] --> Grail Diary
-- END:key

-- START:array
medals = {
   "gold",
   "silver",
   "bronze"
}

print(medals[1]) --> gold
-- END:array

-- START:mixed
ice_cream_scoops = {
   "vanilla",
   "chocolate";

   sprinkles = true
}

print(ice_cream_scoops[1])        --> vanilla
print(ice_cream_scoops.sprinkles) --> true
-- END:mixed

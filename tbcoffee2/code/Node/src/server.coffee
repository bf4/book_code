# Read environment configuration
env = process.env.NODE_ENV or 'development'

# In development mode, enable source map support
if env is 'development'
  require('source-map-support').install()

express = require 'express'
app = express()

# Start our Express server
port = process.env.PORT or 8520
app.listen(port)
console.log "Now listening on port #{port}"

app.use(express.static("#{__dirname}/public"))

Datastore = require('nedb')
db = {}
['boards', 'columns', 'cards'].forEach (collectionKey) =>
  db[collectionKey] = new Datastore
    filename: "#{__dirname}/#{collectionKey}.db"
    autoload: true

  db[collectionKey].ensureIndex {fieldName: 'id', unique: true}
  return

# Set the initial board state if none already exists
db.boards.insert({
  id: 1
  name: 'New Board'
})

bodyParser = require('body-parser')
app.use(bodyParser.json())

['boards', 'columns', 'cards'].forEach (collectionKey) =>

  # Endpoint to fetch the entire collection
  app.get "/#{collectionKey}", (req, res) =>
    db[collectionKey].find {}, (err, collection) =>
      throw err if err
      res.send(collection)
      return

  # Endpoint to add a new object to the collection (assigns id)
  app.post "/#{collectionKey}", (req, res) =>
    object = req.body
    db[collectionKey].count {}, (err, count) =>
      throw err if err
      object.id = count + 1
      db[collectionKey].insert object, (err) =>
        throw err if err
        res.send(object)
        return

  # Endpoint to update an existing object in the collection
  app.put "/#{collectionKey}/:id", (req, res) =>
    query = {id: +req.params.id}
    object = req.body
    options = {}
    db[collectionKey].update query, object, options, (err) =>
      throw err if err
      res.send(object)
      return

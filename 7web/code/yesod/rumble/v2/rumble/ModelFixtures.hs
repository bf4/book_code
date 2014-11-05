module ModelFixtures where

import Model
import Data.Text (Text)
import Database.Persist
import Database.Persist.Sqlite

addFixtures = runSqlite "rumble.sqlite3"

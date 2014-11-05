-- START:withdb
module ModelFun where

import Model
import Data.Text (Text)
import Database.Persist
import Database.Persist.Sqlite

withDB a = runSqlite "rumble.sqlite3" a
-- END:withdb

getUsers :: IO [User]
getUsers = withDB $ do
             users <- selectList [] []
             return $ map entityVal users

getUser :: Text -> IO (Maybe User)
getUser id = withDB $ do
               user <- getBy $ UniqueUser id
               return $ case user of
                          Nothing -> Nothing
                          Just entity -> Just $ entityVal entity


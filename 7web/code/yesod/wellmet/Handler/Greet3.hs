module Handler.Greet3 where

import Import

-- START:func
getGreet3R :: Text -> Handler Html
getGreet3R name = defaultLayout $(widgetFile "greet3")
    where color = "blue" :: Text
-- END:func

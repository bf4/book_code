module Handler.Greet where

import Import

getGreetR :: Text -> Handler Html
getGreetR name = defaultLayout [whamlet|<p>Well met, #{name}! #{after}|]
    where after = "Good day!" :: Text


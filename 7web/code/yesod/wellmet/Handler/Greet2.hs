module Handler.Greet2 where

import Import

-- START:func
getGreet2R :: Text -> Handler Html
getGreet2R name = defaultLayout $ do
                    color <- return ("blue" :: Text)
                    setTitle "Greetings" -- (1)
                    toWidget {- (2) -}[lucius|
                              .greet { font-weight: bold; color: #{color}; }|]
                    toWidget [whamlet|<p .greet>Well met, #{name}!|] -- (3)
-- END:func

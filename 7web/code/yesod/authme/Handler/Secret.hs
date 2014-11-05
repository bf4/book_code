module Handler.Secret where

import Import

getSecretR :: Handler Html
getSecretR = defaultLayout [whamlet|pssssst|]

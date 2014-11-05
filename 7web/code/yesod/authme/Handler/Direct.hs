module Handler.Direct where

import Import
import Yesod.Auth
import Yesod.Auth.BrowserId

authLinkWidget :: Widget
authLinkWidget = do
  onclick <- createOnClick def AuthR -- (1)
  loginIcon <- return $ PluginR "browserid" ["static", "sign-in.png"] -- (2)
  [whamlet|<a href="javascript:#{onclick}()"><img src=@{AuthR loginIcon}></a>|] -- (3)

getDirectR :: Handler Html
getDirectR = do
  user <- maybeAuth
  defaultLayout $ do
             setTitle "AuthMe Direct"
             $(widgetFile "direct")

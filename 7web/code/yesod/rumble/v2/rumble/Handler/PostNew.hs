-- START:get
module Handler.PostNew where
import Import
import Data.Time
import Yesod.Auth
postForm :: Form (UserId -> Int -> UTCTime -> Post) -- (1)
postForm = renderDivs $ Post -- (2)
           <$> areq textField "Title" Nothing
           <*> areq textField "URL" Nothing
getPostNewR :: Handler Html
getPostNewR = do -- (3)
  _ <- requireAuthId
  (postFormWidget, enctype) <- generateFormPost postForm
  defaultLayout $(widgetFile "post-new")
-- END:get

-- START:post
postPostNewR :: Handler Html
postPostNewR = do
  authorId <- requireAuthId
  ((result, _), _) <- runFormPost postForm
  case result of
    FormSuccess makePost -> do -- (4)
                 time <- liftIO getCurrentTime -- (5)
                 post <- runDB $ insert $ makePost authorId 0 time -- (6)
                 redirect $ PostR post -- (7)
    _ -> defaultLayout [whamlet|whoops|]
-- END:post

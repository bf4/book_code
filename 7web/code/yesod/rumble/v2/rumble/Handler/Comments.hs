module Handler.Comments where
import Import
import Data.Time
import Yesod.Auth

makeComment :: PostId -> Textarea -> UserId -> UTCTime -> Comment -- (1)
makeComment post body = \author time -> Comment post author time body

commentForm :: PostId -> Form (UserId -> UTCTime -> Comment) -- (2)
commentForm post = renderDivs $ makeComment post 
                   <$> areq textareaField "Comment" Nothing
postCommentsR :: PostId -> Handler Html -- (3)
postCommentsR post = do
  authorId <- requireAuthId
  ((result, _), _) <- runFormPost $ commentForm post
  case result of
    FormSuccess mkComment -> do
                       time <- liftIO getCurrentTime
                       _ <- runDB $ insert $ mkComment authorId time
                       redirect $ PostR post
    _ -> defaultLayout [whamlet|whoops|]

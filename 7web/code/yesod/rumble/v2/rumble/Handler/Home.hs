{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Home where

import Import

-- START:handlers
getHomeR :: Handler Html
getHomeR = do -- (1)
  posts <- runDB $ selectList [] [Desc PostScore]
  defaultLayout $ do
             setTitle "Rumble"
             $(widgetFile "home")
generatePostWidget :: Entity Post -> Widget -- (2)
generatePostWidget (Entity postId post) = do
  (author, comments) <- handlerToWidget $ runDB $ do -- (3)
                          comments <- selectList [CommentPost ==. postId] 
                                                 [Asc CommentCreated]
                          author <- get404 $ postAuthor post -- (4)
                          return (author, comments)
  $(widgetFile "post")
-- END:handlers

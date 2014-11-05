module Handler.Users where

import Import

-- START:form
userForm :: Form User -- (1)
userForm = renderDivs $ User -- (2)
           <$> areq textField "ID" Nothing -- (3)
           <*> aopt textField "Password" Nothing -- (4)
-- END:form

-- START:get
getUsersR :: Handler Html
getUsersR = do
  users <- runDB $ selectList [] [Asc UserIdent] -- (5)
  (userFormWidget, enctype) <- generateFormPost userForm -- (6)
  defaultLayout $(widgetFile "users") -- (7)
-- END:get

-- START:post
postUsersR :: Handler Html
postUsersR = do
  ((result, _), _) <- runFormPost userForm -- (8)
  case result of
    FormSuccess user -> do -- (9)
                _ <- runDB $ insert user -- (10)
                redirect UsersR -- (11)
    _ -> defaultLayout [whamlet|whoops|]
-- END:post

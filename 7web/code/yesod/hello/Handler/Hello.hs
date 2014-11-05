module Handler.Hello where
import Import
getHelloR :: Handler Html -- (1)
getHelloR = return "Hello, world!" -- (2)

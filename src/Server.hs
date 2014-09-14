{-# LANGUAGE OverloadedStrings #-}
module Server
  ( server
  ) where

import Network.HTTP.Types (status200)
import Network.Wai
import Network.Wai.Handler.Warp (run)

import Server.Environment
-- import Text.Markdown
import Text.Slide

app _ respond = do
  content <- getContent
  respond $ responseLBS status200 [("Content-Type", "text/html")] (renderHtml content)

server :: Int -> IO ()
server port = do
  run 3000 app

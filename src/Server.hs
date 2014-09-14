{-# LANGUAGE OverloadedStrings #-}
module Server
  ( server
  ) where

import Network.HTTP.Types (status200)
import Network.Wai
import Network.Wai.Handler.Warp (run)

import Server.Environment
import Server.Handler
import Text.Slide

app request respond = do
  putStrLn . show . rawPathInfo $ request
  putStrLn . show . pathInfo $ request
  case (pathInfo request) of
    [] -> do
      content <- getContent
      respond $ responseLBS status200 [("Content-Type", "text/html")] (renderHtml content)
    _  -> do
      respond $ responseFile status200 (headers request) (filePath request) Nothing

  -- content <- getContent
  -- respond $ responseLBS status200 [("Content-Type", "text/html")] (renderHtml content)
  -- respond $ responseFile status200 [("Content-Type", "text/html")] (filePath request) Nothing

server :: Int -> IO ()
server port = do
  run port app

{-# LANGUAGE OverloadedStrings #-}
module Server
  ( server
  ) where

import Paths_mdslide

import qualified Data.ByteString.Lazy.Char8 as BS

import Network.HTTP.Types (status200)
import Network.Wai
import Network.Wai.Handler.Warp (run)

import Server.Environment
import Server.Handler
import Text.Slide

app :: Request -> (Response -> IO a) -> IO a
app request respond = do
  case (pathInfo request) of
    [] -> do
      content <- getContent
      respond $ responseLBS status200 [("Content-Type", "text/html")] (renderHtml content)
    _  -> do
      fp <- getDataFileName (filePath request)
      putStrLn fp
      content <- BS.readFile fp
      respond $ responseLBS status200 (headers request) content
--      respond $ responseFile status200 (headers request) (filePath request) Nothing

server :: Int -> IO ()
server port = do
  run port app

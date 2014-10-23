{-# LANGUAGE OverloadedStrings #-}
module Server
  ( server
  ) where

import Paths_mdslide

import Control.Applicative
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
      fp <- getDataFileName ("static/" ++ (filePath request))
      content <- BS.readFile (filePath request) <|> BS.readFile fp
      respond $ responseLBS status200 (headers request) content

server :: Int -> IO ()
server port = do
  run port app

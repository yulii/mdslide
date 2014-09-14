{-# LANGUAGE OverloadedStrings #-}
module Server.Handler
  ( headers
  , filePath
  ) where

import Data.Text          as T
import Data.Text.Encoding as T
import Network.HTTP.Types        (ResponseHeaders)
import Network.Wai

headers :: Request -> ResponseHeaders
headers request = [("Content-Type", ctype request)]
  where
    ctype = T.encodeUtf8 . (T.append "text/") . extension . pathText

filePath :: Request -> FilePath
filePath = T.unpack . (T.append "static/") . pathText

pathText :: Request -> Text
pathText = concatPath . pathInfo


concatPath :: [Text] -> Text
concatPath = T.intercalate "/"

extension :: Text -> Text
extension = snd . T.breakOnEnd "."


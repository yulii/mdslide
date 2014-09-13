{-# LANGUAGE OverloadedStrings #-}
module Server
  ( server
  ) where

import Network.HTTP.Types (status200)
import Network.Wai
import Network.Wai.Handler.Warp (run)

import Server.Environment

-- 一時避難
import qualified Text.Blaze.Html.Renderer.Utf8 as R
import Text.Pandoc (readMarkdown, writeHtml, def)

markdown = R.renderHtml . (writeHtml def) . (readMarkdown def)
-- 

app _ respond = do
  content <- getContent
  respond $ responseLBS status200 [("Content-Type", "text/html")] (markdown content)

server :: Int -> IO ()
server port = do
  run 3000 app

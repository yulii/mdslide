{-# LANGUAGE OverloadedStrings #-}
import Network.Wai
import Network.HTTP.Types (status200)
import Network.Wai.Handler.Warp (run)

import System.Environment (getArgs)

import qualified Text.Blaze.Html.Renderer.Utf8 as R
import Text.Pandoc (readMarkdown, writeHtml, def)

markdown = R.renderHtml . (writeHtml def) . (readMarkdown def)

app _ respond = do
  args <- getArgs
  content <- readFile (head args)
  respond $ responseLBS status200 [("Content-Type", "text/html")] (markdown content)

main :: IO ()
main = do
  run 3000 app

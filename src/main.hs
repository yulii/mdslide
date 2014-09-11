{-# LANGUAGE OverloadedStrings #-}
import Network.Wai
import Network.HTTP.Types (status200)
import Network.Wai.Handler.Warp (run)

import qualified Text.Blaze.Html.Renderer.Utf8 as R
import Text.Pandoc (readMarkdown, writeHtml, def)

markdown = R.renderHtml . (writeHtml def) . (readMarkdown def)

application _ respond = respond $
  responseLBS status200 [("Content-Type", "text/html")] (markdown "# Markdown\nHello World")

main = run 3000 application

module Text.Markdown
  ( markdownToHtml
  , renderHtml
  , renderHtmlBuilder
  ) where

import qualified Text.Blaze.Html.Renderer.Utf8 as R
import           Text.Pandoc (readMarkdown, writeHtml, def)

markdownToHtml = (writeHtml def) . (readMarkdown def)

renderHtml = R.renderHtml . markdownToHtml

renderHtmlBuilder = R.renderHtmlBuilder . markdownToHtml

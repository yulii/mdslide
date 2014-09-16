{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Text.Slide
  ( renderHtml
  ) where

import           Data.ByteString               (ByteString)
import           Data.FileEmbed                (embedFile)
import           Prelude                       hiding (head)
import           Text.Blaze.Html5
import           Text.Blaze.Html5.Attributes
import qualified Text.Blaze.Html.Renderer.Utf8 as R


import qualified Text.Markdown as M
import           Text.Regex (splitRegex, mkRegex)

sfRegex :: String
sfRegex = "<!-- @slide -->"

slides = splitRegex (mkRegex sfRegex)

renderHtml s = R.renderHtml $ do
  docTypeHtml $ do
    head $ do
      link ! rel "stylesheet" ! type_ "text/css" ! href "/css/mdslide.css"
    body $ do
      toMarkup $ slideNumber (slides s) 1
      script ! type_ "text/javascript" $ unsafeByteString js
--      script ! type_ "text/javascript" ! src "/js/mdslide.js" $ ""

slideNumber :: [String] -> Int -> [Html]
slideNumber [] _ = []
slideNumber (x:xs) p = [slideHtml x p] ++ (slideNumber xs (p + 1))

slideHtml :: String -> Int -> Html
slideHtml m p = 
  section ! class_ "slide" ! dataAttribute "page" (toValue p) $ do
    M.markdownToHtml m


js :: ByteString
js = $(embedFile "static/js/mdslide.js")

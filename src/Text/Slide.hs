{-# LANGUAGE OverloadedStrings #-}
module Text.Slide
  ( renderHtml
  ) where


import           Text.Blaze.Html5
import qualified Text.Blaze.Html.Renderer.Utf8 as R

import qualified Text.Markdown as M
import           Text.Regex (splitRegex, mkRegex)

sfRegex :: String
sfRegex = "<!-- @slide -->"

slides = splitRegex (mkRegex sfRegex)

renderHtml s = R.renderHtml $ toMarkup $ slideNumber (slides s) 1

slideNumber :: [String] -> Int -> [Html]
slideNumber [] _ = []
slideNumber (x:xs) p = [slideHtml x p] ++ (slideNumber xs (p + 1))

slideHtml :: String -> Int -> Html
slideHtml m p = 
  section ! dataAttribute "page" (toValue p) $ do
    M.markdownToHtml m


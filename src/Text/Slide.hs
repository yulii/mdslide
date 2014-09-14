{-# LANGUAGE OverloadedStrings #-}
module Text.Slide
  ( renderHtml
  ) where

import           Prelude hiding (head)
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
      link ! rel "stylesheet" ! type_ "text/css" ! href "/css/slide.css"
    body $ do
      toMarkup $ slideNumber (slides s) 1

slideNumber :: [String] -> Int -> [Html]
slideNumber [] _ = []
slideNumber (x:xs) p = [slideHtml x p] ++ (slideNumber xs (p + 1))

slideHtml :: String -> Int -> Html
slideHtml m p = 
  section ! dataAttribute "page" (toValue p) $ do
    M.markdownToHtml m


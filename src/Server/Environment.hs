module Server.Environment
  ( getContent
  ) where

import Control.Monad (liftM)
import System.Environment (getArgs)

getFileName :: IO String
getFileName = liftM head getArgs

getContent :: IO String
getContent = getFileName >>= readFile


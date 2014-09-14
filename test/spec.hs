import Test.Hspec
import Test.QuickCheck

import Test.Server.Environment

describes :: [Spec]
describes = serverEnvironmentSpecs

main :: IO ()
main = mapM_ hspec describes


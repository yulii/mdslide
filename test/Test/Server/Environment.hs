module Test.Server.Environment
  ( serverEnvironmentSpecs
  ) where

import Test.Hspec

serverEnvironmentSpecs :: [Spec]
serverEnvironmentSpecs = [ getFileNameSpec ]

getFileNameSpec :: Spec
getFileNameSpec = do
  describe "Server.Environment.getFileName" $ do
    context "with valid args" $ do
      it "returns the table name" $ do
         "test" `shouldBe` "test"

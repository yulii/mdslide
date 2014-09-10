import Test.Hspec
import Test.QuickCheck

main :: IO ()
main = hspec $ do
  describe "Sample" $ do
    it "should be OK" $ do
      x <- return 1
      x `shouldBe` 1


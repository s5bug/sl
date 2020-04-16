module Main where

import Control.Applicative
import qualified Data.Text.IO as T
import Text.Megaparsec

import Sl.Parser

main :: IO ()
main = do
  x <- T.readFile "test.sl"
  parseTest sl x

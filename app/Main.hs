module Main where

import Data.Char
import System.Environment
import Control.Applicative
import Text.Earley

import Sl.Grammar

main :: IO ()
main = do
  x <- readFile "test.sl"
  print $ fullParses (parser grammar) x

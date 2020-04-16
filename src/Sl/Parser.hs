module Sl.Parser(
    sl
  ) where

import Sl.Absyn

import Data.Text
import Data.Void
import Text.Megaparsec

type Parser = Parsec Void Text

sl :: Parser Source
sl = pure example

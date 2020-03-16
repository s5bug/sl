{-# LANGUAGE RecursiveDo #-}

module Sl.Grammar (
    grammar
  ) where

import Data.Char
import Text.Earley
import Control.Applicative
import Sl.Absyn

sepBy :: Alternative m => m a -> m sep -> m [a]
sepBy p sep = sepBy1 p sep <|> pure []

sepBy1 :: Alternative m => m a -> m sep -> m [a]
sepBy1 p sep = liftA2 (:) p (many (sep *> p))

someBy :: Eq a => a -> Prod r e a [[a]]
someBy s = sepBy (some $ satisfy $ (/=) s) (token s)

grammar :: Grammar r (Prod r String Char Source)
grammar = mdo
  nextLine <- rule $ list "\n" <|> list "\r\n"

  artifact <- rule $ Arti <$> (list "arti " *> sepBy1 (some $ satisfy isAlpha) (token '.')) <* some nextLine
  package <- rule $ Pack <$> (list "pack " *> (sepBy1 (some $ satisfy isAlpha) (token '.') <|> (: []) <$> list "@")) <* some nextLine

  definition <- rule
    $  AbstractFunc <$> some (satisfy isAlpha) <*> many parameterList <*> tpe
   <|> list "trait " *> trait

  trait <- rule $ Trait <$> some (satisfy isAlpha) <*> many generics <*> many definition

  parameterList <- rule
    $  APL <$> (token '(' *> sepBy argument (token ',') <* token ')')
   <|> GPL <$> generics

  argument <- rule $ A <$> some (satisfy isAlpha) <*> tpe

  generics <- rule $ token '[' *> sepBy1 generic (token ',') <* token ']'
  generic <- rule $ G <$> some (satisfy isAlpha)

  tpe <- rule
    $  Qualified <$> some (satisfy isAlpha)
   <|> Lambda <$> (token '[' *> some (satisfy isAlpha) <* token ']') <*> (list "=>>" *> tpe)

  rule $ S <$> artifact <*> package <*> many definition

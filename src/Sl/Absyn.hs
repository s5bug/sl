module Sl.Absyn where

data Source
  = S Artifact Package [Definition]
  deriving Show

newtype Artifact
  = Arti [String]
  deriving Show
data Package
  = Pack [String]
  | Root
  deriving Show

data Statement
  = DefStat Definition
  | Application String [String] -- TODO
  deriving Show

data Definition
  = Func String [ParameterList] Type (Maybe [Statement])
  | Proc String [ParameterList] Type (Maybe [Statement])
  | Macr String [ParameterList] Type [Statement]
  | TypeDef String Type
  | Trait String [[Generic]] [Definition]
  | Class String [ParameterList] [Definition]
  | Object String [Definition]
  deriving Show

data ParameterList
  = APL [Argument]
  | GPL [Generic]
  deriving Show

data Argument
  = A String Type
  deriving Show

data Generic
  = G String -- TODO
  deriving Show

data Type
  = Qualified String -- TODO
  | Lambda String Type -- TODO
  deriving Show

example :: Source
example = S (Arti ["sl", "cats"]) Root [Trait "Monoid" [[G "A"]] [Func "empty" [] (Qualified "A") Nothing]]

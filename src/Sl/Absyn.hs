module Sl.Absyn where

data Source
  = S Artifact Package [Definition]
  deriving Show

newtype Artifact
  = Arti [String]
  deriving Show
newtype Package
  = Pack [String]
  deriving Show

data Statement
  = DefStat Definition
  | Application String [String] -- TODO
  deriving Show

data Definition
  = Func String [ParameterList] Type [Statement]
  | AbstractFunc String [ParameterList] Type
  | Proc String [ParameterList] Type [Statement]
  | AbstractProc String [ParameterList] Type
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
example = S (Arti ["sl", "cats"]) (Pack ["@"]) [Trait "Monoid" [[G "A"]] [AbstractFunc "empty" [] (Qualified "A")]]

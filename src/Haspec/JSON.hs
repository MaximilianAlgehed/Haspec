
module Haspec.JSON where

data JSONType = JSBool
              | JSString
              | JSRational
              | JSObject [JSONType]
              | JSArray
              | JSNull 
              deriving (Ord, Eq, Show)


module Haspec.JSON where

data JSONType = JSBool
              | JSString
              | JSNumber
              | JSObject [JSONType]
              | JSArray
              deriving (Ord, Eq)

showJSONType :: JSONType -> String
showJSONType JSBool        = "Bool"
showJSONType JSString      = "String"
showJSONType JSNumber      = "Number"
showJSONType JSArray       = "[JSON]"
showJSONType (JSObject ts) = "{\n"++(foldl (++) "" (map (\s -> "\t"++s++",\n") (take ((length ts) - 1) (map showJSONType ts))))
                             ++"\t"++(last (map showJSONType ts))++"\n"++"}"

instance Show JSONType where
    show = showJSONType

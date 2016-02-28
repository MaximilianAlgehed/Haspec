module Haspec.JSON where
import Text.PrettyPrint.HughesPJ

data JSONType = JSBool
              | JSString
              | JSNumber
              | JSObject [JSONType]
              | JSArray JSONType
              deriving (Ord, Eq)

toDocJSONType :: JSONType -> Doc
toDocJSONType JSBool        = text "Bool"
toDocJSONType JSString      = text "String"
toDocJSONType JSNumber      = text "Number"
toDocJSONType (JSArray t)   = text "[" <> toDocJSONType t <> text "]"
toDocJSONType (JSObject ts) = text "{" $+$ nest 4 (vcat (map (toDocJSONType) ts)) $+$ text "}"

instance Show JSONType where
    show = show . toDocJSONType

module Haspec.Types.Types where
import Haspec.JSON

data Type = Number
          | String
          | Array Type
          | Sum [Type]
          | Product [Type]
          deriving (Ord, Eq, Show)

typeToJSON :: Type -> JSONType
typeToJSON Number       = JSNumber
typeToJSON String       = JSString
typeToJSON (Array t)    = JSArray $ typeToJSON t
typeToJSON (Sum ts)     = JSObject $ map typeToJSON ts
typeToJSON (Product ts) = JSObject $ map typeToJSON ts

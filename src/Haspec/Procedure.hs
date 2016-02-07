{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE DatatypeContexts #-}

module Haspec.Procedure where
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html.Renderer.Pretty as R
import qualified Text.Blaze.Html5.Attributes as A

data Procedure dataType propertyType = Procedure
                                       {
                                          name       :: String,
                                          docstring  :: String,
                                          arguments  :: [(String, dataType, propertyType)],
                                          returnType :: (dataType, propertyType)
                                       } 
                                       deriving (Ord, Eq, Show)

getDocumentation :: (Show d, Show p) => Procedure d p -> H.Html
getDocumentation procedure = H.div H.!
                             A.id ((H.stringValue . name) procedure)
                             $ do
                                H.head $ H.b $ H.toHtml (name procedure)
                                H.br
                                H.b $ "Description:"
                                H.p $ H.toHtml (docstring procedure)

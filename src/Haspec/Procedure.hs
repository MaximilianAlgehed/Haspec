{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE DatatypeContexts #-}

module Haspec.Procedure where
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html.Renderer.Pretty as R
import qualified Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html4.FrameSet.Attributes as A'

data Procedure dataType propertyType = Procedure
                                       {
                                          name       :: String,
                                          docstring  :: String,
                                          arguments  :: [(String, dataType, propertyType)],
                                          returnType :: (dataType, propertyType)
                                       } 
                                       deriving (Ord, Eq, Show)

mkArgumentsTable :: (Show d, Show p) => Procedure d p -> H.Html
mkArgumentsTable procedure = H.table H.! A'.border (H.stringValue "1") $
                                     H.tr $ H.th "Argument name and type" >> H.th "Must satisfy" >>
                                     (foldl (>>) (return ()) $  
                                     map (\(n, d, p) -> H.tr $ do
                                                                H.td (H.toHtml (n ++ " : " ++ (show d)))
                                                                H.td (H.toHtml (show p))
                                         ) (arguments procedure))

getDocumentation :: (Show d, Show p) => Procedure d p -> H.Html
getDocumentation procedure = H.div H.!
                             A.id ((H.stringValue . name) procedure)
                             $ do
                                H.head $ H.b $ H.toHtml (name procedure)
                                H.br
                                H.b $ "Description:"
                                H.p $ H.toHtml (docstring procedure)
                                mkArgumentsTable procedure

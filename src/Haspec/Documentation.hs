{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE DatatypeContexts #-}

module Haspec.Documentation where
import Haspec.Procedure

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html.Renderer.Pretty as R
import qualified Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html4.FrameSet.Attributes as A'

mkArgumentsTable :: (Show d, Show p) => Procedure d p -> H.Html
mkArgumentsTable procedure = H.table H.! A'.border (H.stringValue "1") $
                                     H.tr $ H.th "Name" >> H.th "Type" >> H.th "Must satisfy" >>
                                     (foldl (>>) (return ()) $  
                                     map (\(n, d, p) -> H.tr $ do
                                                                H.td (H.toHtml n)
                                                                H.td (H.toHtml (show d))
                                                                H.td (H.toHtml (show p))
                                         ) (arguments procedure))

getDocumentation :: (Show d, Show p) => Procedure d p -> H.Html
getDocumentation procedure = H.div H.!
                             A.id ((H.stringValue . name) procedure)
                             $ do
                                H.head $ H.b $ H.toHtml (name procedure)
                                H.br
                                H.p $ "Description:"
                                H.p $ H.toHtml (docstring procedure)
                                mkArgumentsTable procedure
                                H.p $ H.toHtml (show (fst (returnType procedure)))
                                H.p $ H.toHtml (show (snd (returnType procedure)))

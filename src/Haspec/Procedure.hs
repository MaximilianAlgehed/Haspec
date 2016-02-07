{-# LANGUAGE MultiParamTypeClasses #-}

module Haspec.Procedure where

data Procedure dataType propertyType = Procedure
                                       {
                                          name       :: String,
                                          docstring  :: String,
                                          arguments  :: [(String, dataType, propertyType)],
                                          returnType :: (dataType, propertyType)
                                       } 
                                       deriving (Ord, Eq, Show)

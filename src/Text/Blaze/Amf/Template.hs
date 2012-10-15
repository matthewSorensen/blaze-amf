{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}
module Text.Blaze.Amf.Template where

import Language.Haskell.TH
import Text.Blaze.Internal
import Data.Char

lit = return . LitE . StringL

mkElement :: String -> Q [Dec]
mkElement n = do
  let name = mkName n
  t <- name `sigD` [t| Markup -> Markup  |]
  expr <- id [e|Parent|] `appE` lit n `appE` (lit $ '<' : n) `appE` lit ("</"++n++">")
  return [t,
          FunD name [Clause [] (NormalB expr) []], 
          PragmaD $ InlineP name $ InlineSpec True True Nothing]

elements = fmap concat . mapM mkElement

attributeAs :: String -> String -> Q [Dec]
attributeAs attrName haskName = do
  let name = mkName haskName
  t <- name `sigD` [t| AttributeValue -> Attribute |]
  custom <- id [e| customAttribute |]
  return [t,
          FunD name [Clause [] (NormalB $ AppE custom $ LitE $ StringL attrName) []],
          PragmaD $ InlineP name $ InlineSpec True True Nothing]

attributes :: [String] -> Q [Dec]
attributes = fmap concat . mapM mkAttr
    where mkAttr n = attributeAs n $ map (replace . toLower) n
          replace ' ' = '_'
          replace '-' = '_'
          replace x   = x


{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}
module Text.Blaze.Amf.Template where

import Language.Haskell.TH
import Text.Blaze.Internal
import Data.Char

lit = return . LitE . StringL


elementAs :: String -> String -> Q [Dec]
elementAs xmlName haskName = do
  let name = mkName haskName
  t <- name `sigD` [t| Markup -> Markup  |]
  expr <- id [e|Parent|] `appE` lit xmlName `appE` (lit $ '<' : xmlName) `appE` lit ("</"++ xmlName ++">")
  return [t,
          FunD name [Clause [] (NormalB expr) []], 
          PragmaD $ InlineP name $ InlineSpec True True Nothing]

attributeAs :: String -> String -> Q [Dec]
attributeAs attrName haskName = do
  let name = mkName haskName
  t <- name `sigD` [t| AttributeValue -> Attribute |]
  custom <- id [e| customAttribute |]
  return [t,
          FunD name [Clause [] (NormalB $ AppE custom $ LitE $ StringL attrName) []],
          PragmaD $ InlineP name $ InlineSpec True True Nothing]

sanitize :: String -> String
sanitize = map (replace . toLower)
    where replace ' ' = '_'
          replace '-' = '_'
          replace x   = x

asToList :: (String -> String -> Q [Dec]) -> [String] -> Q [Dec]
asToList f = fmap concat . mapM (\s -> f s $ sanitize s)

elements :: [String] -> Q [Dec]
elements = asToList elementAs

attributes ::  [String] -> Q [Dec]
attributes = asToList attributeAs

{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}
module Text.Blaze.Amf.Template where

import Language.Haskell.TH

import Text.Blaze.Internal

-- so we need to generate generic elements for:

-- amf, object, color, r,g b, a, mesh, vertices, vertex, coordinates, x y z, normal, edge
-- d{x,y,z}{1,2}
-- n{x,y,z}
-- volume
-- triangle
-- v{1,2,3}
-- texture
-- material composite constellation instance delta{x,y,z}
-- r{x,y,z}
-- metadata

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



-- special meta-data combinators for Name, Description, Url, etc...

-- Attributes for:
-- unit id materialid type width height depth objectid

-- profile gets its own combinators taking a colorspace data type
{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}
module Text.Blaze.Amf.Attributes where

import Text.Blaze.Amf.Template
import Text.Blaze.Internal
import Language.Haskell.TH

$(attributeAs "id" "id_")
$(attributeAs "type" "type_")
$(attributes ["unit","profile","materialid","width","height","depth","objectid"])
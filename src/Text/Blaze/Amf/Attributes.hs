{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}
module Text.Blaze.Amf.Attributes where

import Text.Blaze.Amf.Template
import Text.Blaze.Internal
import Text.Blaze
import Language.Haskell.TH

$(attributeAs "id" "id_")
$(attributeAs "type" "type_")
$(attributes ["materialid","width","height","depth","objectid"])
$(attributes ["rtexid","gtexid","btexid","atexid","version"])

data Unit = Inch | Millimeter | Meter | Feet | Micron
            deriving(Show,Eq)

instance ToValue Unit where
    toValue = preEscapedToValue

    preEscapedToValue Inch = "inch"
    preEscapedToValue Millimeter = "millimeter"
    preEscapedToValue Meter = "meter"
    preEscapedToValue Feet = "feet"
    preEscapedToValue Micron = "micron"

unit :: Unit -> Attribute
unit = customAttribute "unit" . preEscapedToValue

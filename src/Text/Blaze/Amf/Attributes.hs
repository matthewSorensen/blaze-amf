{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}
module Text.Blaze.Amf.Attributes where

import Text.Blaze.Amf.Template
import Text.Blaze.Internal
import Text.Blaze
import Language.Haskell.TH

$(attributeAs "id" "id_")
$(attributeAs "type" "type_")
$(attributes ["materialid","width","height","depth","objectid"])

data ColorSpace = SRGB | AdobeRGB | WideGamutRGB | CIERGB | CIELAB | CIEXYZ
                  deriving(Show,Eq)

instance ToValue ColorSpace where
    toValue = preEscapedToValue

    preEscapedToValue SRGB = "sRGB"
    preEscapedToValue AdobeRGB = "AdobeRGB" 
    preEscapedToValue WideGamutRGB = "Wide-Gamut-RGB" 
    preEscapedToValue CIERGB = "CIERGB"
    preEscapedToValue CIELAB = "CIELAB"
    preEscapedToValue CIEXYZ = "CIEXYZ"

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

profile :: ColorSpace -> Attribute
profile = customAttribute "profile" . preEscapedToValue
{-# LANGUAGE OverloadedStrings #-}
module Text.Blaze.Amf.Metadata where

import Data.Text
import Text.Blaze
import Text.Blaze.Amf.Elements (metadata)
import Text.Blaze.Amf.Attributes (type_)

meta :: ToMarkup value => Text -> value -> Markup
meta key value = metadata ! type_ (toValue key) $ toMarkup value

name, description, url, author, company, cad, revision :: ToMarkup v => v -> Markup
tolerance, volume, elastomodulus, poissonratio :: ToMarkup v => v -> Markup

name = meta "name"
description = meta "description"
url = meta "url"
author = meta "author"
company = meta "company"
cad = meta "cad"
revision = meta "revision"
tolerance = meta "tolerance"
volume = meta "volume"
elastomodulus = meta "elastomodulus"
poissonratio = meta "poissonratio"

data ColorSpace = SRGB | AdobeRGB | WideGamutRGB | CIERGB | CIELAB | CIEXYZ
                  deriving(Show,Eq)

instance ToMarkup ColorSpace where
    toMarkup = preEscapedToMarkup

    preEscapedToMarkup SRGB = "sRGB"
    preEscapedToMarkup AdobeRGB = "AdobeRGB" 
    preEscapedToMarkup WideGamutRGB = "Wide-Gamut-RGB" 
    preEscapedToMarkup CIERGB = "CIERGB"
    preEscapedToMarkup CIELAB = "CIELAB"
    preEscapedToMarkup CIEXYZ = "CIEXYZ"

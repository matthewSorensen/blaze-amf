{-# LANGUAGE OverloadedStrings, TemplateHaskell #-}
module Text.Blaze.Amf.Elements where

import Text.Blaze.Amf.Template
import Text.Blaze.Internal
import Language.Haskell.TH
import Text.Blaze.Amf.Attributes
import Data.Monoid

$(elements ["x","y","z"])
$(elements ["nx","ny","nz"])
$(elements ["r","g","b","a"])
$(elements ["v1","v2","v3"])
$(elements ["rx","ry","rz"])
$(elements ["dx1","dy1","dz1"])
$(elements ["dx2","dy2","dz2"])
$(elements ["deltax","deltay","deltaz"])
$(elements ["object","color","mesh","vertices","vertex"])
$(elements ["coordinates","normal","edge","volume","triangle","metadata"])
$(elements ["texture","material","composite","constellation","instance"])

$("amf" `elementAs` "raw_amf")

amf :: Unit -> Markup -> Markup
amf u cont = unsafeByteString "<?xml version=\"1.0\"?>" `mappend` 
             (raw_amf ! unit u $ cont)
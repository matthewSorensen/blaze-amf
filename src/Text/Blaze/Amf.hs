module Text.Blaze.Amf (renderAsLBS, renderAsZIP, Markup) where

import Text.Blaze
import Text.Blaze.Renderer.Utf8
import Data.ByteString.Lazy (ByteString)
import Codec.Archive.Zip

-- This really should use a larger buffer size.
renderAsLBS :: Markup -> ByteString
renderAsLBS = renderMarkup

-- Note that this has a horridly wrong modification time.
renderAsZIP :: String -> Markup -> ByteString
renderAsZIP file mark = fromArchive $ addEntryToArchive (toEntry file 0 $ renderAsLBS mark) emptyArchive


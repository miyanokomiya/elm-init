module Update.Lib exposing (..)

import Json.Decode
import Json.Decode.Pipeline


type alias Position =
    { x : Int
    , y : Int
    }


xDecorder : Json.Decode.Decoder (Int -> b) -> Json.Decode.Decoder b
xDecorder =
    Json.Decode.Pipeline.required "offsetX" Json.Decode.int


yDecorder : Json.Decode.Decoder (Int -> b) -> Json.Decode.Decoder b
yDecorder =
    Json.Decode.Pipeline.required "offsetY" Json.Decode.int

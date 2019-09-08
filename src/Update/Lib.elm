module Update.Lib exposing (..)

import Html.Events
import Json.Decode
import Json.Decode.Pipeline
import VirtualDom


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


messageWithTrue : msg -> ( msg, Bool )
messageWithTrue msg =
    ( msg, True )


stopPropagationOn : String -> Json.Decode.Decoder msg -> VirtualDom.Attribute msg
stopPropagationOn event decorder =
    Html.Events.stopPropagationOn event (Json.Decode.map messageWithTrue decorder)


preventDefaultOn : String -> Json.Decode.Decoder msg -> VirtualDom.Attribute msg
preventDefaultOn event decorder =
    Html.Events.preventDefaultOn event (Json.Decode.map messageWithTrue decorder)

module Update.Element exposing (..)

import Json.Decode
import Json.Decode.Pipeline


type Mode
    = Default
    | DownStart
    | Moving


type alias Position =
    { x : Int
    , y : Int
    }


type alias Model =
    { mode : Mode
    , downP : Position
    , moveP : Position
    , selectedIds : List String
    }


init : Model
init =
    { mode = Default
    , downP = Position 0 0
    , moveP = Position 0 0
    , selectedIds = []
    }


type Msg
    = Down Int Int
    | Move Int Int
    | Up


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        Down x y ->
            ( { model | downP = Position x y }, Cmd.none )

        Move x y ->
            ( { model | mode = DownStart, downP = Position x y }, Cmd.none )

        Up ->
            ( { model | mode = Default }, Cmd.none )


xDecorder : Json.Decode.Decoder (Int -> b) -> Json.Decode.Decoder b
xDecorder =
    Json.Decode.Pipeline.required "offsetX" Json.Decode.int


yDecorder : Json.Decode.Decoder (Int -> b) -> Json.Decode.Decoder b
yDecorder =
    Json.Decode.Pipeline.required "offsetY" Json.Decode.int


onDownDecoder : Json.Decode.Decoder Msg
onDownDecoder =
    Json.Decode.succeed Down
        |> xDecorder
        |> yDecorder

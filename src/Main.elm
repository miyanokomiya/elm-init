module Main exposing (Msg(..), main, update, view)

import Browser
import Html
import Html.Events
import Json.Decode
import Json.Decode.Pipeline
import Model.Element
import Model.Path
import Model.Rect
import Model.Svg
import View.Element
import VirtualDom


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Position =
    { x : Int
    , y : Int
    }


type alias Model =
    { position : Position
    , svg : Model.Element.Element
    }


init : Model
init =
    { position = Position 0 0
    , svg =
        Model.Element.Svg
            [ Model.Svg.Viewbox 0 0 400 200
            , Model.Svg.Width 400
            , Model.Svg.Height 200
            ]
            []
            [ Model.Element.Path
                [ Model.Path.D [ Model.Path.M 0 0, Model.Path.L 0 30, Model.Path.L 30 30 ] ]
                [ Model.Element.Fill "red", Model.Element.Stroke "blue" ]
            , Model.Element.Path
                [ Model.Path.D [ Model.Path.M 0 0, Model.Path.L 30 0, Model.Path.L 30 20 ] ]
                [ Model.Element.Fill "red", Model.Element.Stroke "blue" ]
            , Model.Element.Rect
                [ Model.Rect.X 50, Model.Rect.Y 50, Model.Rect.Width 20, Model.Rect.Height 40, Model.Rect.Rx 5, Model.Rect.Ry 10 ]
                [ Model.Element.Fill "red", Model.Element.Stroke "blue" ]
            ]
    }



-- UPDATE


type Msg
    = Select Int Int
    | Create


update : Msg -> Model -> Model
update msg model =
    case Debug.log "msg" msg of
        Select x y ->
            { model | position = Position x y }

        Create ->
            model



-- VIEW


xDecorder : Json.Decode.Decoder (Int -> b) -> Json.Decode.Decoder b
xDecorder =
    Json.Decode.Pipeline.required "offsetX" Json.Decode.int


yDecorder : Json.Decode.Decoder (Int -> b) -> Json.Decode.Decoder b
yDecorder =
    Json.Decode.Pipeline.required "offsetY" Json.Decode.int


onClickDecoder : Json.Decode.Decoder Msg
onClickDecoder =
    Json.Decode.succeed Select
        |> xDecorder
        |> yDecorder


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.p [] [ Html.text (String.fromInt model.position.x), Html.text ", ", Html.text (String.fromInt model.position.y) ]
        , Html.div [ Html.Events.on "click" onClickDecoder ]
            [ View.Element.element model.svg
            ]
        ]

module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Model.Path
import View.Path
import View.Svg exposing (..)
import VirtualDom exposing (Attribute, Node, attribute, nodeNS)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    Model.Path.Path


init : Model
init =
    Model.Path.Path
        { fill = "black"
        , stroke = "blue"
        }
        [Model.Path.M 0 0, Model.Path.L 30 30]



-- UPDATE


type Msg
    = A


update : Msg -> Model -> Model
update msg model =
    model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ svg [ viewbox 0 0 100 100 ]
            [ path [ d [ M 0 0, L 10 2, Z ], stroke "black" ] []
            , path [ d [ M 0 0, L 1 20, Z ], stroke "black" ] []
            , View.Path.view model
            ]
        ]

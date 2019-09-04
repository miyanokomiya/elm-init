module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import View.Svg exposing (..)
import VirtualDom exposing (Attribute, Node, attribute, nodeNS)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        , svg [ viewbox 0 0 100 100 ]
            [ path [ d [ M 0 0, L 10 2, Z ], stroke "black" ] []
            , path [ d [ M 0 0, L 1 20, Z ], stroke "black" ] []
            ]
        ]

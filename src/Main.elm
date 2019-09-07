module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, div)
import Model.Element
import Model.Path
import Model.Rect
import Model.Svg
import View.Element
import VirtualDom


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { svg : Model.Element.Element
    }


init : Model
init =
    { svg =
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
    = Select


update : Msg -> Model -> Model
update msg model =
    case msg of
        Select ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ View.Element.element model.svg ]

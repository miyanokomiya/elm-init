module Main exposing (main)

import Browser
import Html
import Html.Events
import Json.Decode
import Json.Decode.Pipeline
import Model.Element
import Model.Path
import Model.Rect
import Model.Svg
import Update.Element
import View.Element
import VirtualDom


type alias Position =
    { x : Int
    , y : Int
    }


type alias Model =
    { canvas : Update.Element.Model
    , svg : Model.Element.Element
    }


init : Int -> ( Model, Cmd Msg )
init now =
    ( { canvas = Update.Element.init
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
    , Cmd.none
    )



-- UPDATE


type Msg
    = Canvas Update.Element.Msg
    | Tmp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        Canvas canvasMsg ->
            let
                ( subModel, subCmd ) =
                    Update.Element.update canvasMsg model.canvas
            in
            ( { model | canvas = subModel }, Cmd.map Canvas subCmd )

        Tmp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW

--  Html.Events.on "click" Update.Element.onDownDecoder 
view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.p [] [ Html.text (String.fromInt model.canvas.downP.x), Html.text ", ", Html.text (String.fromInt model.canvas.downP.y) ]
        , Html.map Canvas
            (Html.div []
                [ View.Element.element model.svg
                ]
            )
        ]


main : Program Int Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

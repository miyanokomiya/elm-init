port module Main exposing (main)

import Browser
import Html
import Html.Events
import Model.Element
import Model.Path
import Model.Rect
import Model.Svg
import Update.Element
import View.Element
import VirtualDom


type alias Model =
    { canvas : Model.Element.Model
    }


init : Int -> ( Model, Cmd Msg )
init now =
    ( { canvas = Model.Element.init
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
                [ View.Element.element model.canvas.svg
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

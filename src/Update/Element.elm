module Update.Element exposing (..)

import Json.Decode
import Model.Element
import Model.Path
import Model.Rect
import Random
import Update.Lib
import Update.Path


type Msg
    = Down Int Int Int
    | Move Int Int
    | Up
    | DownElement Int
    | Roll
    | NewFace Int


execSvgTree : (Model.Element.Element -> Model.Element.Element) -> Model.Element.Element -> Model.Element.Element
execSvgTree fn element =
    case element of
        Model.Element.Svg id a b c ->
            Model.Element.Svg id a b (List.map (execSvgTree fn) c)
                |> fn

        Model.Element.Path id a b s ->
            Model.Element.Path id a b s
                |> fn

        Model.Element.Rect id a b s ->
            Model.Element.Rect id a b s
                |> fn


select : Int -> Model.Element.Element -> Model.Element.Element
select target element =
    case element of
        Model.Element.Svg _ _ _ _ ->
            element

        Model.Element.Path id a b s ->
            Model.Element.Path id a b { s | selected = target == id }

        Model.Element.Rect id a b s ->
            Model.Element.Rect id a b { s | selected = target == id }


moveIfSelected : Float -> Float -> Model.Element.Element -> Model.Element.Element
moveIfSelected dx dy element =
    case element of
        Model.Element.Svg _ _ _ _ ->
            element

        Model.Element.Path id a b s ->
            if s.selected then
                Model.Element.Path id
                    (Update.Path.move dx dy a)
                    b
                    s

            else
                element

        Model.Element.Rect id a b s ->
            if s.selected then
                Model.Element.Rect id
                    (List.map
                        (\from ->
                            case from of
                                Model.Rect.X x ->
                                    Model.Rect.X (x + dx)

                                Model.Rect.Y y ->
                                    Model.Rect.Y (y + dy)

                                Model.Rect.Width val ->
                                    from

                                Model.Rect.Height _ ->
                                    from

                                Model.Rect.Rx _ ->
                                    from

                                Model.Rect.Ry _ ->
                                    from
                        )
                        a
                    )
                    b
                    s

            else
                element


onDownSvg : Int -> Model.Element.Element -> Model.Element.Element
onDownSvg id element =
    execSvgTree (select id) element


onMoveSvg : Int -> Int -> Model.Element.Element -> Model.Element.Element
onMoveSvg dx dy element =
    execSvgTree (moveIfSelected (toFloat dx) (toFloat dy)) element


clearSelect : Model.Element.Element -> Model.Element.Element
clearSelect element =
    execSvgTree (select 0) element


update : Msg -> Model.Element.Model -> ( Model.Element.Model, Cmd Msg )
update msg model =
    -- case Debug.log "msg" msg of
    case msg of
        Down _ x y ->
            let
                p =
                    Model.Element.Position x y
            in
            if model.mode == Model.Element.Default then
                ( { model | mode = Model.Element.DownCanvasStart, downP = p, moveP = p }, Cmd.none )

            else
                ( { model | downP = p, moveP = p }, Cmd.none )

        Move x y ->
            if model.mode == Model.Element.DownElementStart || model.mode == Model.Element.MovingElement then
                let
                    dx =
                        x - model.moveP.x

                    dy =
                        y - model.moveP.y
                in
                ( { model | mode = Model.Element.MovingElement, moveP = Model.Element.Position x y, svg = onMoveSvg dx dy model.svg }, Cmd.none )

            else
                ( model, Cmd.none )

        Up ->
            -- update Roll { model | mode = Model.Element.Default }
            if Debug.log "a" model.mode == Model.Element.DownCanvasStart then
                ( { model | mode = Model.Element.Default, svg = clearSelect model.svg }, Cmd.none )

            else
                ( { model | mode = Model.Element.Default }, Cmd.none )

        DownElement id ->
            ( { model | mode = Model.Element.DownElementStart, svg = execSvgTree (select id) model.svg }, Cmd.none )

        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newFace ->
            ( model
            , Cmd.none
            )


onDownDecoder : Int -> Json.Decode.Decoder Msg
onDownDecoder id =
    Json.Decode.succeed (Down id)
        |> Update.Lib.xDecorder
        |> Update.Lib.yDecorder


onDownElementDecoder : Int -> Json.Decode.Decoder Msg
onDownElementDecoder id =
    Json.Decode.succeed (DownElement id)


onMoveDecoder : Json.Decode.Decoder Msg
onMoveDecoder =
    Json.Decode.succeed Move
        |> Update.Lib.xDecorder
        |> Update.Lib.yDecorder


onUpDecoder : Json.Decode.Decoder Msg
onUpDecoder =
    Json.Decode.succeed Up

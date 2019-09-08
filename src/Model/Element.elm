module Model.Element exposing (..)

import Model.Path
import Model.Rect
import Model.Svg


type Attribute
    = Fill String
    | Stroke String


type Element
    = Svg Int (List Model.Svg.Attribute) (List Attribute) (List Element)
    | Path Int (List Model.Path.Attribute) (List Attribute) ElementState
    | Rect Int (List Model.Rect.Attribute) (List Attribute) ElementState


type alias ElementState =
    { selected : Bool
    }


type Mode
    = Default
    | DownStart
    | Moving


type alias Position =
    { x : Int
    , y : Int
    }


type alias Model =
    { svg : Element
    , mode : Mode
    , downP : Position
    , moveP : Position
    , selectedIds : List Int
    }


initElementState : ElementState
initElementState =
    { selected = False
    }


init : Model
init =
    { svg =
        Svg 1
            [ Model.Svg.Viewbox 0 0 400 200
            , Model.Svg.Width 400
            , Model.Svg.Height 200
            ]
            []
            [ Path 2
                [ Model.Path.D [ Model.Path.M 0 0, Model.Path.L 0 30, Model.Path.L 30 30 ] ]
                [ Fill "red", Stroke "blue" ]
                initElementState
            , Path 3
                [ Model.Path.D [ Model.Path.M 0 0, Model.Path.L 30 0, Model.Path.L 30 20 ] ]
                [ Fill "red", Stroke "blue" ]
                initElementState
            , Rect 4
                [ Model.Rect.X 50, Model.Rect.Y 50, Model.Rect.Width 20, Model.Rect.Height 40, Model.Rect.Rx 5, Model.Rect.Ry 10 ]
                [ Fill "red", Stroke "blue" ]
                initElementState
            ]
    , mode = Default
    , downP = Position 0 0
    , moveP = Position 0 0
    , selectedIds = []
    }

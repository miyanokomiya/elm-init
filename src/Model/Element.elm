module Model.Element exposing (Attribute(..), Element(..))

import Model.Path
import Model.Rect
import Model.Svg


type Attribute
    = Fill String
    | Stroke String


type Element
    = Svg (List Model.Svg.Attribute) (List Attribute) (List Element)
    | Path (List Model.Path.Attribute) (List Attribute)
    | Rect (List Model.Rect.Attribute) (List Attribute)

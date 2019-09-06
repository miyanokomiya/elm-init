module Model.Element exposing (Attribute(..), Element(..))

import Model.Path
import Model.Rect


type Attribute
    = Fill String
    | Stroke String


type Element
    = Path (List Model.Path.Attribute) (List Attribute)
    | Rect (List Model.Rect.Attribute) (List Attribute)

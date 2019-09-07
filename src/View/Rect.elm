module View.Rect exposing (attributes)

import Model.Rect
import View.Lib
import VirtualDom



attribute : Model.Rect.Attribute -> VirtualDom.Attribute msg
attribute attr =
    case attr of
        Model.Rect.X x ->
            View.Lib.floatAttribute "x" x

        Model.Rect.Y y ->
            View.Lib.floatAttribute "y" y

        Model.Rect.Width width ->
            View.Lib.floatAttribute "width" width

        Model.Rect.Height height ->
            View.Lib.floatAttribute "height" height

        Model.Rect.Rx rx ->
            View.Lib.floatAttribute "rx" rx

        Model.Rect.Ry ry ->
            View.Lib.floatAttribute "ry" ry


attributes : List Model.Rect.Attribute -> List (VirtualDom.Attribute msg)
attributes attrs =
    List.map attribute attrs

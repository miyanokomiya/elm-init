module View.Rect exposing (attributes)

import Model.Rect
import VirtualDom


floatAttribute : String -> Float -> VirtualDom.Attribute msg
floatAttribute name val =
    VirtualDom.attribute name (String.fromFloat val)


attribute : Model.Rect.Attribute -> VirtualDom.Attribute msg
attribute attr =
    case attr of
        Model.Rect.X x ->
            floatAttribute "x" x

        Model.Rect.Y y ->
            floatAttribute "y" y

        Model.Rect.Width width ->
            floatAttribute "width" width

        Model.Rect.Height height ->
            floatAttribute "height" height

        Model.Rect.Rx rx ->
            floatAttribute "rx" rx

        Model.Rect.Ry ry ->
            floatAttribute "ry" ry


attributes : List Model.Rect.Attribute -> List (VirtualDom.Attribute msg)
attributes attrs =
    List.map attribute attrs

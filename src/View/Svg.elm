module View.Svg exposing (attributes)

import Model.Svg
import View.Lib
import VirtualDom


attribute : Model.Svg.Attribute -> VirtualDom.Attribute msg
attribute attr =
    case attr of
        Model.Svg.Viewbox x y w h ->
            View.Lib.floatListAttribute "viewbox" [ x, y, w, h ]

        Model.Svg.Width width ->
            View.Lib.floatAttribute "width" width

        Model.Svg.Height height ->
            View.Lib.floatAttribute "height" height


attributes : List Model.Svg.Attribute -> List (VirtualDom.Attribute msg)
attributes attrs =
    List.append (List.map attribute attrs) [ VirtualDom.attribute "xmlns" View.Lib.xmlns ]

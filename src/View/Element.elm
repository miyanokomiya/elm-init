module View.Element exposing (element, elements)

import Model.Element
import View.Lib
import View.Path
import View.Rect
import View.Svg
import VirtualDom


attribute : Model.Element.Attribute -> VirtualDom.Attribute msg
attribute attr =
    case attr of
        Model.Element.Fill fill ->
            VirtualDom.attribute "fill" fill

        Model.Element.Stroke stroke ->
            VirtualDom.attribute "stroke" stroke


attributes : List Model.Element.Attribute -> List (VirtualDom.Attribute msg)
attributes attrs =
    List.map attribute attrs


toDom : String -> List (VirtualDom.Attribute msg) -> List (VirtualDom.Node msg) -> VirtualDom.Node msg
toDom name attrs children =
    VirtualDom.nodeNS View.Lib.xmlns
        name
        attrs
        children


element : Model.Element.Element -> VirtualDom.Node msg
element elm =
    case elm of
        Model.Element.Svg a b c ->
            toDom "svg" (List.append (View.Svg.attributes a) (attributes b)) (List.map element c)

        Model.Element.Path a b ->
            toDom "path" (List.append (View.Path.attributes a) (attributes b)) []

        Model.Element.Rect a b ->
            toDom "rect" (List.append (View.Rect.attributes a) (attributes b)) []


elements : List Model.Element.Element -> List (VirtualDom.Node msg)
elements elms =
    List.map element elms

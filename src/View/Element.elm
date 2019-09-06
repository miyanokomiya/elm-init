module View.Element exposing (elements)

import Model.Element
import View.Path
import View.Rect
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
    VirtualDom.nodeNS "http://www.w3.org/2000/svg"
        name
        attrs
        children


element : Model.Element.Element -> VirtualDom.Node msg
element elm =
    case elm of
        Model.Element.Path a b ->
            toDom "path" (List.append (View.Path.attributes a) (attributes b)) []

        Model.Element.Rect a b ->
            toDom "rect" (List.append (View.Rect.attributes a) (attributes b)) []


elements : List Model.Element.Element -> List (VirtualDom.Node msg)
elements elms =
    List.map element elms

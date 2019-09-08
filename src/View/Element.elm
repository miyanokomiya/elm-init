module View.Element exposing (element, elements)

import Html.Events
import Model.Element
import Update.Element
import View.Lib
import View.Path
import View.Rect
import View.Svg
import VirtualDom


attribute : Model.Element.Attribute -> VirtualDom.Attribute Update.Element.Msg
attribute attr =
    case attr of
        Model.Element.Fill fill ->
            VirtualDom.attribute "fill" fill

        Model.Element.Stroke stroke ->
            VirtualDom.attribute "stroke" stroke


attributes : List Model.Element.Attribute -> List (VirtualDom.Attribute Update.Element.Msg) -> List (VirtualDom.Attribute Update.Element.Msg)
attributes attrs handlers =
    List.append (List.map attribute attrs) handlers


toDom : String -> List (VirtualDom.Attribute Update.Element.Msg) -> List (VirtualDom.Node Update.Element.Msg) -> VirtualDom.Node Update.Element.Msg
toDom name attrs children =
    VirtualDom.nodeNS View.Lib.xmlns
        name
        attrs
        children


element : Model.Element.Element -> VirtualDom.Node Update.Element.Msg
element elm =
    case elm of
        Model.Element.Svg a b c ->
            toDom "svg" (List.append (View.Svg.attributes a) (attributes b [])) (List.map element c)

        Model.Element.Path a b ->
            toDom "path" (List.append (View.Path.attributes a) (attributes b [ Html.Events.on "click" Update.Element.onDownDecoder ])) []

        Model.Element.Rect a b ->
            toDom "rect" (List.append (View.Rect.attributes a) (attributes b [])) []


elements : List Model.Element.Element -> List (VirtualDom.Node Update.Element.Msg)
elements elms =
    List.map element elms

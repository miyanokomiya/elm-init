module View.Element exposing (element, elements)

import Model.Element
import Update.Element
import Update.Lib
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


attributes : List Model.Element.Attribute -> List (VirtualDom.Attribute Update.Element.Msg)
attributes attrs =
    List.map attribute attrs


attributesWithHandler : Int -> List Model.Element.Attribute -> List (VirtualDom.Attribute Update.Element.Msg)
attributesWithHandler id attrs =
    List.append (attributes attrs)
        [ Update.Lib.stopPropagationOn "mousedown" (Update.Element.onDownDecoder id)

        , Update.Lib.stopPropagationOn "mousemove" Update.Element.onMoveDecoder
        , Update.Lib.stopPropagationOn "mouseup" Update.Element.onUpDecoder
        ]


toDom : String -> List (VirtualDom.Attribute Update.Element.Msg) -> List (VirtualDom.Node Update.Element.Msg) -> VirtualDom.Node Update.Element.Msg
toDom name attrs children =
    VirtualDom.nodeNS View.Lib.xmlns
        name
        attrs
        children


selectedAttributes : Model.Element.ElementState -> List Model.Element.Attribute -> List Model.Element.Attribute
selectedAttributes status attrs =
    if status.selected then
        [ Model.Element.Fill "blue", Model.Element.Stroke "black" ]

    else
        attrs


element : Model.Element.Element -> VirtualDom.Node Update.Element.Msg
element elm =
    case elm of
        Model.Element.Svg id a b c ->
            toDom "svg" (List.append (View.Svg.attributes a) (attributesWithHandler id b)) (List.map element c)

        Model.Element.Path id a b s ->
            toDom "path" (List.append (View.Path.attributes a) (attributesWithHandler id (selectedAttributes s b))) []

        Model.Element.Rect id a b s ->
            toDom "rect" (List.append (View.Rect.attributes a) (attributesWithHandler id (selectedAttributes s b))) []


elements : List Model.Element.Element -> List (VirtualDom.Node Update.Element.Msg)
elements elms =
    List.map element elms

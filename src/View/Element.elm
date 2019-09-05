module View.Element exposing (view)

import Model.Element exposing (Element)
import VirtualDom exposing (Attribute, Node, attribute, nodeNS)


view :  String ->Element -> List (Attribute msg) -> List (Node msg) -> Node msg
view name elm attributes children =
    nodeNS "http://www.w3.org/2000/svg"
        name
        (List.append [ attribute "fill" elm.fill, attribute "stroke" elm.stroke ] attributes)
        children

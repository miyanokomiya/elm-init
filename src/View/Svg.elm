module View.Svg exposing (..)

import VirtualDom exposing (Attribute, Node, attribute, nodeNS)


type SvgAttribute
    = Viewbox Float Float Float Float
    | Fill String
    | Stroke String
    | D (List DItem)


svgAttributeToString : SvgAttribute -> Attribute msg
svgAttributeToString attr =
    case attr of
        Viewbox x y w h ->
            List.map String.fromFloat [ x, y, w, h ]
                |> String.join " "
                |> attribute "viewbox"

        Fill s ->
            attribute "fill" s

        Stroke s ->
            attribute "stroke" s

        D items ->
            List.map dItemToString items
                |> String.join " "
                |> attribute "d"


element : String -> List (Attribute msg) -> List (Node msg) -> Node msg
element tag attrubutes children =
    nodeNS "http://www.w3.org/2000/svg" tag attrubutes children


type DItem
    = M Float Float
    | L Float Float
    | Z


dItemToString : DItem -> String
dItemToString ditem =
    case ditem of
        M x y ->
            "M " ++ String.fromFloat x ++ " " ++ String.fromFloat y

        L x y ->
            "L " ++ String.fromFloat x ++ " " ++ String.fromFloat y

        Z ->
            "Z"


d : List DItem -> Attribute msg
d items =
    svgAttributeToString (D items)


path : List (Attribute msg) -> List (Node msg) -> Node msg
path attrubutes children =
    element "path" attrubutes children


viewbox : Float -> Float -> Float -> Float -> Attribute msg
viewbox x y w h =
    svgAttributeToString (Viewbox x y w h)


fill : String -> Attribute msg
fill s =
    svgAttributeToString (Fill s)


stroke : String -> Attribute msg
stroke s =
    svgAttributeToString (Stroke s)


svg : List (Attribute msg) -> List (Node msg) -> Node msg
svg attrubutes children =
    element "svg" attrubutes children

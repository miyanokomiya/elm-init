module View.Lib exposing (floatAttribute, floatListAttribute, xmlns)

import VirtualDom


xmlns : String
xmlns =
    "http://www.w3.org/2000/svg"


floatAttribute : String -> Float -> VirtualDom.Attribute msg
floatAttribute name val =
    VirtualDom.attribute name (String.fromFloat val)


floatListAttribute : String -> List Float -> VirtualDom.Attribute msg
floatListAttribute name vals =
    List.map String.fromFloat vals
        |> String.join " "
        |> VirtualDom.attribute name

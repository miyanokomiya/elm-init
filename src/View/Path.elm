module View.Path exposing (view)

import Model.Path exposing (Command(..), Path)
import View.Element
import VirtualDom exposing (Attribute, Node, attribute)


commandToString : Command -> String
commandToString command =
    case command of
        M x y ->
            "M " ++ String.fromFloat x ++ " " ++ String.fromFloat y

        L x y ->
            "L " ++ String.fromFloat x ++ " " ++ String.fromFloat y

        Z ->
            "Z"


commandsToD : List Command -> Attribute msg
commandsToD commands =
    List.map commandToString commands
        |> String.join " "
        |> attribute "d"


view : Path -> Node msg
view path =
    View.Element.view "path" path.element [ commandsToD path.d ] []

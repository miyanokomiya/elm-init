module View.Path exposing (attributes)

import Model.Path
import VirtualDom


commandToString : Model.Path.Command -> String
commandToString command =
    case command of
        Model.Path.M x y ->
            "M " ++ String.fromFloat x ++ " " ++ String.fromFloat y

        Model.Path.L x y ->
            "L " ++ String.fromFloat x ++ " " ++ String.fromFloat y

        Model.Path.Z ->
            "Z"


attrD : List Model.Path.Command -> VirtualDom.Attribute msg
attrD commands =
    List.map commandToString commands
        |> String.join " "
        |> VirtualDom.attribute "d"


attribute : Model.Path.Attribute -> VirtualDom.Attribute msg
attribute attr =
    case attr of
        Model.Path.D commands -> attrD commands

attributes : List Model.Path.Attribute -> List (VirtualDom.Attribute msg)
attributes attrs =
    List.map attribute attrs

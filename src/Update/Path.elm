module Update.Path exposing (move)

import Json.Decode
import Model.Path
import Update.Lib


moveCommand : Float -> Float -> Model.Path.Command -> Model.Path.Command
moveCommand dx dy from =
    case from of
        Model.Path.M x y ->
            Model.Path.M (x + dx) (y + dy)

        Model.Path.L x y ->
            Model.Path.L (x + dx) (y + dy)

        Model.Path.Z ->
            Model.Path.Z


moveAttribute : Float -> Float -> Model.Path.Attribute -> Model.Path.Attribute
moveAttribute dx dy from =
    case from of
        Model.Path.D commands ->
            Model.Path.D (List.map (moveCommand dx dy) commands)


move : Float -> Float -> List Model.Path.Attribute -> List Model.Path.Attribute
move dx dy from =
    List.map
        (moveAttribute dx dy)
        from

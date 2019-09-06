module Model.Path exposing (Command(..), Attribute(..))


type Command
    = M Float Float
    | L Float Float
    | Z


type Attribute
    = D (List Command)

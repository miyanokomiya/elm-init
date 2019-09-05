module Model.Path exposing (..)

import Model.Element exposing (Element)


type Command
    = M Float Float
    | L Float Float
    | Z


type alias Path =
    { element : Element
    , d : List Command
    }

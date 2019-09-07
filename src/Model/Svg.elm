module Model.Svg exposing (Attribute(..))


type Attribute
    = Viewbox Float Float Float Float
    | Width Float
    | Height Float

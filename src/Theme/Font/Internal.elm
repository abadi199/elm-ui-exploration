module Theme.Font.Internal exposing (Theme(..))

import Css


type Theme
    = Theme
        { families : Maybe (List String)
        , size : Maybe Float
        , weight : Maybe Int
        }

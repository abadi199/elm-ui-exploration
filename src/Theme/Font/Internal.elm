module Theme.Font.Internal
    exposing
        ( Theme(..)
        , Weight(..)
        )

import Css


type Theme
    = Theme
        { families : Maybe (List String)
        , size : Maybe Float
        , weight : Maybe Weight
        }


type Weight
    = Weight Int

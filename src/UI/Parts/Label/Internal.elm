module UI.Parts.Label.Internal
    exposing
        ( Label(..)
        , Theme(..)
        )

import Css


type Theme
    = Theme
        { color : Maybe Css.Color
        , backgroundColor : Maybe Css.Color
        , fontFamilies : Maybe (List String)
        }


type Label
    = Label String
    | InvisibleLabel String

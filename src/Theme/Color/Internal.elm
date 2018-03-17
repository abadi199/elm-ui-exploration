module Theme.Color.Internal
    exposing
        ( Color(..)
        , Theme(..)
        )

import Css


type Theme
    = Theme
        { foreground : Maybe Color
        , background : Maybe Color
        , border : Maybe Color
        }


type Color
    = CssColor Css.Color

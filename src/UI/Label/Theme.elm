module UI.Label.Theme
    exposing
        ( Style
        , Theme
        , backgroundColor
        , color
        , emptyTheme
        )

import Color exposing (Color)


type Theme
    = Theme
        { color : Maybe Color
        , backgroundColor : Maybe Color
        }


emptyTheme : Theme
emptyTheme =
    Theme
        { color = Nothing
        , backgroundColor = Nothing
        }


type alias Style =
    Theme -> Theme



-- STYLES


color : Color -> Style
color c =
    \(Theme theme) -> Theme { theme | color = Just c }


backgroundColor : Color -> Style
backgroundColor c =
    \(Theme theme) -> Theme { theme | backgroundColor = Just c }

module UI.Pars.Label.Theme
    exposing
        ( Style
        , Theme
        , backgroundColor
        , color
        , emptyTheme
        , fontFamilies
        )

import Css exposing (Color)
import UI.Parts.Label.Internal as Internal


type alias Theme =
    Internal.Theme


type alias Style =
    Theme -> Theme



-- STYLES


color : Color -> Style
color c =
    \(Internal.Theme theme) -> Internal.Theme { theme | color = Just c }


backgroundColor : Color -> Style
backgroundColor c =
    \(Internal.Theme theme) -> Internal.Theme { theme | backgroundColor = Just c }


fontFamilies : List String -> Style
fontFamilies value =
    \(Internal.Theme theme) -> Internal.Theme { theme | fontFamilies = Just value }


emptyTheme : Theme
emptyTheme =
    Internal.Theme
        { color = Nothing
        , backgroundColor = Nothing
        , fontFamilies = Nothing
        }

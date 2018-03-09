module UI.Input.Text.Theme
    exposing
        ( Style
        , Theme
        , emptyTheme
        , label
        )

import Theme.Helpers as Theme
import UI.Label.Theme as Label


type Theme
    = Theme { label : Maybe Label.Theme }


emptyTheme : Theme
emptyTheme =
    Theme { label = Nothing }


type alias Style =
    Theme -> Theme



-- STYLES


label : List Label.Style -> Style
label labelStyles =
    \(Theme theme) -> Theme { theme | label = Just (Theme.process Label.emptyTheme labelStyles) }

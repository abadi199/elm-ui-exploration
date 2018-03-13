module UI.Input.Text.Theme
    exposing
        ( Style
        , Theme
        , emptyTheme
        , label
        )

import Theme.Helpers as Theme
import UI.Input.Text.Internal as Internal
import UI.Label.Theme as Label


type alias Theme =
    Internal.Theme


type alias Style =
    Theme -> Theme



-- STYLES


label : List Label.Style -> Style
label labelStyles =
    \(Internal.Theme theme) -> Internal.Theme { theme | label = Just (Theme.process Label.emptyTheme labelStyles) }


emptyTheme : Theme
emptyTheme =
    Internal.Theme { label = Nothing }

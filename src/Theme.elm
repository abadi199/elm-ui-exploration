module Theme
    exposing
        ( Style
        , Theme
        , inputText
        , theme
        )

import Theme.Helpers as Theme
import UI.Input.Text.Theme as InputText


type Theme
    = Theme { inputText : Maybe InputText.Theme }


emptyTheme : Theme
emptyTheme =
    Theme { inputText = Nothing }


type alias Style =
    Theme -> Theme


theme : List Style -> Theme
theme styles =
    Theme.process emptyTheme styles


inputText : List InputText.Style -> Style
inputText styles =
    \(Theme theme) -> Theme { theme | inputText = Just (Theme.process InputText.emptyTheme styles) }

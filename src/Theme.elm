module Theme
    exposing
        ( Style
        , Theme
        , inputText
        , theme
        )

import Theme.Helpers as Theme
import Theme.Internal as Internal
import UI.Elements.Input.Text.Theme as InputText


type alias Theme =
    Internal.Theme


emptyTheme : Theme
emptyTheme =
    Internal.Theme { inputText = Nothing }


type alias Style =
    Theme -> Theme


theme : List Style -> Theme
theme styles =
    Theme.process emptyTheme styles


inputText : List InputText.Style -> Style
inputText styles =
    \(Internal.Theme theme) ->
        Internal.Theme
            { theme
                | inputText = Just (Theme.process (theme.inputText |> Maybe.withDefault InputText.emptyTheme) styles)
            }

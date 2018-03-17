module UI.Elements.Input.Text.Theme
    exposing
        ( Style
        , Theme
        , emptyTheme
        , errorIcon
        , errorMessage
        , helpIcon
        , helpMessage
        , input
        , label
        )

import Theme.Helpers as Theme
import UI.Elements.Input.Text.Internal as Internal
import UI.Parts.Icon.Theme as Icon
import UI.Parts.Input.Theme as Input
import UI.Parts.Label.Theme as Label
import UI.Parts.Message.Theme as Message


type alias Theme =
    Internal.Theme


type alias Style =
    Theme -> Theme



-- STYLES


label : List Label.Style -> Style
label labelStyles =
    \(Internal.Theme theme) ->
        Internal.Theme
            { theme
                | label = Just (Theme.process (theme.label |> Maybe.withDefault Label.emptyTheme) labelStyles)
            }


input : List Input.Style -> Style
input inputStyles =
    \(Internal.Theme theme) ->
        Internal.Theme
            { theme
                | input = Just (Theme.process (theme.input |> Maybe.withDefault Input.emptyTheme) inputStyles)
            }


helpIcon : List Icon.Style -> Style
helpIcon helpIconStyles =
    \(Internal.Theme theme) ->
        Internal.Theme
            { theme
                | helpIcon = Just (Theme.process (theme.helpIcon |> Maybe.withDefault Icon.emptyTheme) helpIconStyles)
            }


errorIcon : List Icon.Style -> Style
errorIcon errorIconStyles =
    \(Internal.Theme theme) ->
        Internal.Theme
            { theme
                | errorIcon = Just (Theme.process (theme.errorIcon |> Maybe.withDefault Icon.emptyTheme) errorIconStyles)
            }


helpMessage : List Message.Style -> Style
helpMessage helpMessageStyles =
    \(Internal.Theme theme) ->
        Internal.Theme
            { theme
                | helpMessage = Just (Theme.process (theme.helpMessage |> Maybe.withDefault Message.emptyTheme) helpMessageStyles)
            }


errorMessage : List Message.Style -> Style
errorMessage errorMessageStyles =
    \(Internal.Theme theme) ->
        Internal.Theme
            { theme
                | errorMessage = Just (Theme.process (theme.errorMessage |> Maybe.withDefault Message.emptyTheme) errorMessageStyles)
            }


emptyTheme : Theme
emptyTheme =
    Internal.Theme
        { label = Nothing
        , input = Nothing
        , helpIcon = Nothing
        , errorIcon = Nothing
        , helpMessage = Nothing
        , errorMessage = Nothing
        }

module Theme.Color
    exposing
        ( Style
        , Theme
        , background
        , batch
        , border
        , color
        , css
        , emptyTheme
        , foreground
        )

import Css
import Theme.Color.Internal as Internal
import Theme.Helpers as Helpers exposing (append)


type alias Theme =
    Internal.Theme


type alias Style =
    Theme -> Theme


batch : List Style -> Style
batch styles =
    \theme ->
        Helpers.process theme styles


emptyTheme : Theme
emptyTheme =
    Internal.Theme
        { foreground = Nothing
        , background = Nothing
        , border = Nothing
        }


foreground : Internal.Color -> Style
foreground color =
    \(Internal.Theme theme) -> Internal.Theme { theme | foreground = Just color }


background : Internal.Color -> Style
background color =
    \(Internal.Theme theme) -> Internal.Theme { theme | background = Just color }


border : Internal.Color -> Style
border color =
    \(Internal.Theme theme) -> Internal.Theme { theme | border = Just color }


css : Theme -> Css.Style
css (Internal.Theme theme) =
    []
        |> append foregroundCss theme.foreground
        |> append backgroundCss theme.background
        |> append borderCss theme.border
        |> Css.batch


foregroundCss : Internal.Color -> Css.Style
foregroundCss color =
    case color of
        Internal.CssColor cssColor ->
            Css.color cssColor


backgroundCss : Internal.Color -> Css.Style
backgroundCss color =
    case color of
        Internal.CssColor cssColor ->
            Css.backgroundColor cssColor


borderCss : Internal.Color -> Css.Style
borderCss color =
    case color of
        Internal.CssColor cssColor ->
            Css.batch [ Css.borderColor cssColor, Css.borderWidth (Css.px 1), Css.borderStyle Css.solid ]


color : Css.Color -> Internal.Color
color cssColor =
    Internal.CssColor cssColor

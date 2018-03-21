module UI.Parts.Input.Theme
    exposing
        ( Style
        , Theme
        , batch
        , color
        , css
        , emptyTheme
        , font
        , spacing
        )

import Css
import Theme.Color as Color
import Theme.Font as Font
import Theme.Helpers as Helpers
import Theme.Spacing as Spacing
import UI.Parts.Internal as Internal


type alias Theme =
    Internal.InputTheme


type alias Style =
    Theme -> Theme


batch : List Style -> Style
batch styles =
    \theme ->
        let
            updatedTheme =
                Helpers.process theme styles
        in
        updatedTheme


css : Theme -> Css.Style
css (Internal.InputTheme theme) =
    Css.batch
        [ Helpers.normalize
        , Color.css theme.color
        , Font.css theme.font
        , Spacing.css theme.spacing
        ]


color : List Color.Style -> Style
color colorStyles =
    let
        colorTheme =
            Helpers.process Color.emptyTheme colorStyles
    in
    \(Internal.InputTheme theme) -> Internal.InputTheme { theme | color = colorTheme }


font : List Font.Style -> Style
font fontStyles =
    let
        fontTheme =
            Helpers.process Font.emptyTheme fontStyles
    in
    \(Internal.InputTheme theme) -> Internal.InputTheme { theme | font = fontTheme }


spacing : List Spacing.Style -> Style
spacing spacingStyles =
    let
        spacingTheme =
            Helpers.process Spacing.emptyTheme spacingStyles
    in
    \(Internal.InputTheme theme) -> Internal.InputTheme { theme | spacing = spacingTheme }


emptyTheme : Theme
emptyTheme =
    Internal.InputTheme
        { color = Color.emptyTheme
        , font = Font.emptyTheme
        , spacing = Spacing.emptyTheme
        }

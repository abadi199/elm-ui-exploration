module UI.Parts.Label.Theme
    exposing
        ( Style
        , Theme
        , batch
        , color
        , css
        , emptyTheme
        , font
        , theme
        )

import Css
import Theme.Color as Color
import Theme.Color.Internal as Color
import Theme.Font as Font
import Theme.Font.Internal as Font
import Theme.Helpers as Helpers
import UI.Parts.Internal as Internal


type alias Theme =
    Internal.LabelTheme


type alias Style =
    Theme -> Theme



-- STYLES


batch : List Style -> Style
batch styles =
    \theme ->
        let
            updatedTheme =
                Helpers.process theme styles
        in
        updatedTheme


theme : List Style -> Theme
theme styles =
    emptyTheme


css : Theme -> Css.Style
css (Internal.LabelTheme theme) =
    Css.batch
        [ Color.css theme.color
        , Font.css theme.font
        ]


color : List Color.Style -> Style
color colorStyles =
    let
        colorTheme =
            Helpers.process Color.emptyTheme colorStyles
    in
    \(Internal.LabelTheme theme) -> Internal.LabelTheme { theme | color = colorTheme }


font : List Font.Style -> Style
font fontStyles =
    let
        fontTheme =
            Helpers.process Font.emptyTheme fontStyles
    in
    \(Internal.LabelTheme theme) -> Internal.LabelTheme { theme | font = fontTheme }


emptyTheme : Theme
emptyTheme =
    Internal.LabelTheme
        { color = Color.emptyTheme
        , font = Font.emptyTheme
        }

module UI.Parts.Message.Theme
    exposing
        ( Style
        , Theme
        , emptyTheme
        )

import UI.Parts.Internal as Internal


type alias Theme =
    Internal.MessageTheme


emptyTheme : Theme
emptyTheme =
    Internal.MessageTheme {}


type alias Style =
    Theme -> Theme
